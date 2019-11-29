#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QThread>
#include <QFont>
#include "Data.h"
#include "RosIntegration.h"
#include "RosListener.h"
#include "properties.h"
#include <ros/ros.h>
#include <nav_msgs/Path.h>
#include <sensor_msgs/Image.h>
int main(int argc, char *argv[])
{
//    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    // set default font as Lato
    QFont font = app.font();
    font.setFamily("Lato");
    app.setFont(font);

    QQmlApplicationEngine engine;
    qRegisterMetaType <ros::NodeHandle>("ros::NodeHandle");
    qRegisterMetaType <robot_screen::RobotCoordinates>("robot_screen::RobotCoordinates");
    qRegisterMetaType <std_msgs::String::ConstPtr>("std_msgs::String::ConstPtr");
    qRegisterMetaType <nav_msgs::Path>("nav_msgs::Path");
    qRegisterMetaType <sensor_msgs::ImageConstPtr>("sensor_msgs::ImageConstPtr");
    Data data;
    Properties properties;
    RosIntegration rosInte;
    RosListener rosLis;
    QThread threadRosLis;

    rosLis.moveToThread(&threadRosLis);
    threadRosLis.start();

    QObject::connect(&rosInte, &RosIntegration::sigNodeHandle, &rosLis, &RosListener::onReceivedNodeHandle);
    QObject::connect(&rosLis, &RosListener::sigStringListener, &rosInte, &RosIntegration::onReceivedString);
    QObject::connect(&rosLis, &RosListener::sigRobotCoordinatesListener, &rosInte, &RosIntegration::onReceivedRobotCoordinates);
    QObject::connect(&rosLis, &RosListener::sigNavPathListener, &rosInte, &RosIntegration::onReceivedNavPath);
    QObject::connect(&rosLis, &RosListener::sigImageMapListener, &rosInte, &RosIntegration::onReceivedImageMap);
    rosInte.initRos(argc, argv);

    engine.rootContext()->setContextProperty("Data", &data);
    engine.rootContext()->setContextProperty("Properties", &properties);
    engine.rootContext()->setContextProperty("RosIntegration", &rosInte);

    engine.load(QUrl(QStringLiteral("src/robot_screen/src/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
