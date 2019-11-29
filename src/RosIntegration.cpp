#include "RosIntegration.h"
using robot_screen::ScreenNavigation;
using robot_screen::ScreenPresentation;
RosIntegration::RosIntegration(QObject *parent) : QObject(parent){

}

void RosIntegration::initRos(int argc, char** argv) {
    ros::init(argc, argv, "robot_screen_controller");
    ros::NodeHandle n;

    emit sigNodeHandle(n);
    this->screenNavTopic = n.advertise<robot_screen::ScreenNavigation>("screen_navigation", 100);
    this->screenPresentTopic = n.advertise<robot_screen::ScreenPresentation>("screen_presentation", 100);
    this->requestMapTopic = n.advertise<std_msgs::String>("request_map", 100);
//    qDebug() << "init ros";
    this->requestImageMap();

}

int RosIntegration::pointToPixel(float point)
{
    int sizeImg = 384;
    int mapSize = 20;
    float ratio = sizeImg / mapSize;
    int inPoint = int(ratio * (point + 10));
    return inPoint;
}

void RosIntegration::requestImageMap()
{
//    qDebug() << "request map";
    std_msgs::String msg;
    QString stringRequest = "request";
    msg.data = stringRequest.toStdString();

    this->requestMapTopic.publish(msg);
}

void RosIntegration::onReceivedString(const std_msgs::String::ConstPtr& msg)
{
//    qDebug() << msg->data.c_str();
    ROS_INFO("I heard: %s", msg->data.c_str());
}

void RosIntegration::onReceivedRobotCoordinates(const robot_screen::RobotCoordinates &msg)
{
//    qDebug() << "I heart x:" << msg.x << ", y: " << msg.y;
    QPoint coordinates;
    coordinates.setX(msg.x);
    coordinates.setY(msg.y);
    setRobotCoordinates(coordinates);
}

void RosIntegration::onReceivedNavPath(const nav_msgs::Path &msg){
    //qDebug() << "received path";
//    qDebug() << msg.poses.size();
    int lenPath = msg.poses.size();
    QList<int> nav_x, nav_y;
    for (int i = 0; i < lenPath; i++) {
        float x = msg.poses[i].pose.position.x;
        float y = msg.poses[i].pose.position.y;
        qDebug() << "x: " << x << ",y: " << y;
        int _x = pointToPixel(x);
        int _y = pointToPixel(-y);
        nav_x.push_back(_x);
        nav_y.push_back(_y);
        qDebug() << nav_x.last() << " " << nav_y.last();

    }
    setNavPath_x(nav_x);
    setNavPath_y(nav_y);
}

void RosIntegration::onReceivedImageMap(const sensor_msgs::ImageConstPtr &msg)
{
    qDebug() << "received image map";
    cv::Mat img = cv_bridge::toCvShare(msg, "mono8")->image;

//    qDebug() << img.at<uchar>(200, 200);
}

void RosIntegration::setNavPath_x(QList<int> navPath_x)
{
    if (m_navPath_x == navPath_x)
        return;

    m_navPath_x = navPath_x;
    emit navPath_xChanged(m_navPath_x);
}

void RosIntegration::setNavPath_y(QList<int> navPath_y)
{
    if (m_navPath_y == navPath_y)
        return;

    m_navPath_y = navPath_y;
    emit navPath_yChanged(m_navPath_y);
}

QPoint RosIntegration::robotCoordinates() const
{
    return m_robotCoordinates;
}


QList<int> RosIntegration::navPath_x() const
{
    return m_navPath_x;
}

QList<int> RosIntegration::navPath_y() const
{
    return m_navPath_y;
}

void RosIntegration::setRobotCoordinates(QPoint robotCoordinates)
{
    if (m_robotCoordinates == robotCoordinates)
        return;

    m_robotCoordinates = robotCoordinates;
    emit robotCoordinatesChanged(m_robotCoordinates);
}


void RosIntegration::leadToObject(int objectID) {
    ScreenNavigation msg = ScreenNavigation();
    msg.objectId = objectID;
    this->screenNavTopic.publish(msg);
}

void RosIntegration::presentObject(int objectID) {
    ScreenPresentation msg= ScreenPresentation();
    msg.objectId = objectID;
    this->screenPresentTopic.publish(msg);
}









