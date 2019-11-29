#include "RosListener.h"

using robot_screen::RobotCoordinates;
RosListener::RosListener(QObject *parent) : QObject(parent){
    //    qDebug() << "rosListener was created";
}

void RosListener::robotCoordinatesCallback(const robot_screen::RobotCoordinates &msg){
//    ROS_INFO("I heard x: %d, y: %d", msg.x, msg.y);
    emit sigRobotCoordinatesListener(msg);
}
void RosListener::stringCallback(const std_msgs::String::ConstPtr& msg){
    //    ROS_INFO("I heart %s", msg->data.c_str());
    //    qDebug() << msg->data.c_str();
    //    QString data = msg->data.c_str();
    emit sigStringListener(msg);
}

void RosListener::navPathCallback(const nav_msgs::Path &msg){
    emit sigNavPathListener(msg);
}

void RosListener::imageMapCallback(const sensor_msgs::ImageConstPtr &msg)
{
    emit sigImageMapListener(msg);
}

void RosListener::onReceivedNodeHandle(ros::NodeHandle n){
    ros::Subscriber sub4= n.subscribe("request_map", 1000, &RosListener::stringCallback, this);
    ros::Subscriber sub = n.subscribe("robotCoordinates", 1000, &RosListener::robotCoordinatesCallback, this);
    ros::Subscriber sub2 = n.subscribe("global_plan/planner/plan", 1000, &RosListener::navPathCallback, this);
    ros::Subscriber sub3 = n.subscribe("image", 1000, &RosListener::imageMapCallback, this);
    ros::spin();
}


