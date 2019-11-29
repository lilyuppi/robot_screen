#ifndef ROSINTEGRATION_H
#define ROSINTEGRATION_H

#include <QString>
#include <QDebug>
#include <QObject>
#include <QQmlEngine>
#include <QDir>
#include <ros/ros.h>
#include <QPoint>
#include <QList>
#include <QSize>
#include <ros/ros.h>
#include <sstream>
#include <image_transport/image_transport.h>
#include <opencv2/highgui.hpp>
#include <cv_bridge/cv_bridge.h>
#include <std_msgs/String.h>
#include <robot_screen/ScreenNavigation.h>
#include <robot_screen/ScreenPresentation.h>
#include <robot_screen/RobotCoordinates.h>
#include <sensor_msgs/Image.h>
//#include <geometry_msgs/PoseStamped.h>
//#include <geometry_msgs/Pose.h>
//#include <geometry_msgs/Point.h>
#include <nav_msgs/Path.h>
class RosIntegration : public QObject{
    Q_OBJECT
    Q_PROPERTY(QPoint robotCoordinates READ robotCoordinates WRITE setRobotCoordinates NOTIFY robotCoordinatesChanged)

    Q_PROPERTY(QList<int> navPath_x READ navPath_x WRITE setNavPath_x NOTIFY navPath_xChanged)
    Q_PROPERTY(QList<int> navPath_y READ navPath_y WRITE setNavPath_y NOTIFY navPath_yChanged)

public:
    explicit RosIntegration(QObject *parent = 0);
    Q_INVOKABLE void leadToObject(int);
    Q_INVOKABLE void presentObject(int);
    Q_INVOKABLE void requestImageMap();
    void initRos(int, char**);
    int pointToPixel(float point);    
    QPoint robotCoordinates() const;
    QList<int> navPath_x() const;
    QList<int> navPath_y() const;

public slots:
    void setRobotCoordinates(QPoint robotCoordinates);
    void onReceivedString(const std_msgs::String::ConstPtr& msg);
    void onReceivedRobotCoordinates(const robot_screen::RobotCoordinates& msg);
    void onReceivedNavPath(const nav_msgs::Path& msg);
    void onReceivedImageMap(const sensor_msgs::ImageConstPtr& msg);
    void setNavPath_x(QList<int> navPath_x);

    void setNavPath_y(QList<int> navPath_y);

signals:
    void robotCoordinatesChanged(QPoint robotCoordinates);
    void sigNodeHandle(ros::NodeHandle n);
    void navPath_xChanged(QList<int> navPath_x);

    void navPath_yChanged(QList<int> navPath_y);

private:
    ros::Publisher screenPresentTopic;
    ros::Publisher screenNavTopic;
    ros::Publisher requestMapTopic;
    QPoint m_robotCoordinates;
    QList<int> m_navPath_x;
    QList<int> m_navPath_y;
};

#endif
