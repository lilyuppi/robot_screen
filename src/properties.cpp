#include "properties.h"

Properties::Properties(QObject *parent) : QObject(parent)
{
    init();
}



QSize Properties::sizeNavBar() const
{
    return m_sizeNavBar;
}

void Properties::init()
{
    QSize size;

    size.setWidth(1280);
    size.setHeight(800);
    setSizeDisplay(size);

    size.setWidth(1205);
    size.setHeight(720);
    setSizeMain(size);

    size.setWidth(1205);
    size.setHeight(80);
    setSizeHeader(size);

    size.setWidth(75);
    size.setHeight(800);
    setSizeNavBar(size);

    size.setWidth(275);
    size.setHeight(800);
    setSizeNavBarExpand(size);

    size.setWidth(247);
    size.setHeight(45);
    setSizeItemInNavExpand(size);

    size.setWidth(990);
    size.setHeight(557);
    setSizeImageView(size);

    size.setWidth(155);
    size.setHeight(680);
    setSizeImageViewRelative(size);

    setSizeIconMenu(45);
}

QSize Properties::sizeDisplay() const
{
    return m_sizeDisplay;
}

QSize Properties::sizeNavBarExpand() const
{
    return m_sizeNavBarExpand;
}

QSize Properties::sizeItemInNavExpand() const
{
    return m_sizeItemInNavExpand;
}

QSize Properties::sizeMain() const
{
    return m_sizeMain;
}

QSize Properties::sizeHeader() const
{
    return m_sizeHeader;
}

QSize Properties::sizeImageView() const
{
    return m_sizeImageView;
}

QSize Properties::sizeImageViewRelative() const
{
    return m_sizeImageViewRelative;
}

int Properties::sizeIconMenu() const
{
    return m_sizeIconMenu;
}

void Properties::setSizeNavBar(QSize sizeNavBar)
{
    if (m_sizeNavBar == sizeNavBar)
        return;

    m_sizeNavBar = sizeNavBar;
    emit sizeNavBarChanged(m_sizeNavBar);
}

void Properties::setSizeDisplay(QSize sizeDisplay)
{
    if (m_sizeDisplay == sizeDisplay)
        return;

    m_sizeDisplay = sizeDisplay;
    emit sizeDisplayChanged(m_sizeDisplay);
}

void Properties::setSizeIconMenu(int sizeIconMenu)
{
    if (m_sizeIconMenu == sizeIconMenu)
        return;

    m_sizeIconMenu = sizeIconMenu;
    emit sizeIconMenuChanged(m_sizeIconMenu);
}

void Properties::setSizeNavBarExpand(QSize sizeNavBarExpand)
{
    if (m_sizeNavBarExpand == sizeNavBarExpand)
        return;

    m_sizeNavBarExpand = sizeNavBarExpand;
    emit sizeNavBarExpandChanged(m_sizeNavBarExpand);
}

void Properties::setSizeItemInNavExpand(QSize sizeItemInNavExpand)
{
    if (m_sizeItemInNavExpand == sizeItemInNavExpand)
        return;

    m_sizeItemInNavExpand = sizeItemInNavExpand;
    emit sizeItemInNavExpandChanged(m_sizeItemInNavExpand);
}

void Properties::setSizeMain(QSize sizeMain)
{
    if (m_sizeMain == sizeMain)
        return;

    m_sizeMain = sizeMain;
    emit sizeMainChanged(m_sizeMain);
}

void Properties::setSizeHeader(QSize sizeHeader)
{
    if (m_sizeHeader == sizeHeader)
        return;

    m_sizeHeader = sizeHeader;
    emit sizeHeaderChanged(m_sizeHeader);
}

void Properties::setSizeImageView(QSize sizeImageView)
{
    if (m_sizeImageView == sizeImageView)
        return;

    m_sizeImageView = sizeImageView;
    emit sizeImageViewChanged(m_sizeImageView);
}

void Properties::setSizeImageViewRelative(QSize sizeImageViewRelative)
{
    if (m_sizeImageViewRelative == sizeImageViewRelative)
        return;

    m_sizeImageViewRelative = sizeImageViewRelative;
    emit sizeImageViewRelativeChanged(m_sizeImageViewRelative);
}
