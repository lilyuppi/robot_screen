#ifndef ROSLISTENER_H
#define ROSLISTENER_H

#include <QString>
#include <QDebug>
#include <QObject>
#include <QQmlEngine>
#include <QDir>
#include <ros/ros.h>
#include <QPoint>
#include <ros/ros.h>
#include <std_msgs/String.h>
#include <robot_screen/RobotCoordinates.h>
#include <nav_msgs/Path.h>
#include <sensor_msgs/Image.h>
#include <image_transport/image_transport.h>
#include <opencv2/highgui.hpp>
#include <cv_bridge/cv_bridge.h>

class RosListener : public QObject{
    Q_OBJECT

public:
    explicit RosListener(QObject *parent = 0);
    void robotCoordinatesCallback(const robot_screen::RobotCoordinates& msg);
    void stringCallback(const std_msgs::String::ConstPtr& msg);
    void navPathCallback(const nav_msgs::Path& msg);
    void imageMapCallback(const sensor_msgs::ImageConstPtr& msg);
public slots:
    void onReceivedNodeHandle(ros::NodeHandle n);

signals:
    void sigRobotCoordinatesListener(const robot_screen::RobotCoordinates& msg);
    void sigStringListener(const std_msgs::String::ConstPtr& msg);
    void sigNavPathListener(const nav_msgs::Path& msg);
    void sigImageMapListener(const sensor_msgs::ImageConstPtr& msg);
};

#endif // ROSLISTENER_H
