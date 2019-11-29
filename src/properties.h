#ifndef PROPERTIES_H
#define PROPERTIES_H

#include <QObject>
#include <QSize>
class Properties : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QSize sizeDisplay READ sizeDisplay WRITE setSizeDisplay NOTIFY sizeDisplayChanged)
    Q_PROPERTY(QSize sizeMain READ sizeMain WRITE setSizeMain NOTIFY sizeMainChanged)
    Q_PROPERTY(QSize sizeHeader READ sizeHeader WRITE setSizeHeader NOTIFY sizeHeaderChanged)
    Q_PROPERTY(QSize sizeNavBar READ sizeNavBar WRITE setSizeNavBar NOTIFY sizeNavBarChanged)
    Q_PROPERTY(QSize sizeNavBarExpand READ sizeNavBarExpand WRITE setSizeNavBarExpand NOTIFY sizeNavBarExpandChanged)
    Q_PROPERTY(QSize sizeItemInNavExpand READ sizeItemInNavExpand WRITE setSizeItemInNavExpand NOTIFY sizeItemInNavExpandChanged)
    Q_PROPERTY(QSize sizeImageView READ sizeImageView WRITE setSizeImageView NOTIFY sizeImageViewChanged)
    Q_PROPERTY(QSize sizeImageViewRelative READ sizeImageViewRelative WRITE setSizeImageViewRelative NOTIFY sizeImageViewRelativeChanged)
    Q_PROPERTY(int sizeIconMenu READ sizeIconMenu WRITE setSizeIconMenu NOTIFY sizeIconMenuChanged)
public:
    explicit Properties(QObject *parent = 0);
    void init();
    int sizeIconMenu() const;
    QSize sizeNavBar() const;
    QSize sizeDisplay() const;
    QSize sizeNavBarExpand() const;
    QSize sizeItemInNavExpand() const;
    QSize sizeMain() const;
    QSize sizeHeader() const;
    QSize sizeImageView() const;    
    QSize sizeImageViewRelative() const;

public slots:
    void setSizeNavBar(QSize sizeNavBar);
    void setSizeDisplay(QSize sizeDisplay);
    void setSizeIconMenu(int sizeIconMenu);
    void setSizeNavBarExpand(QSize sizeNavBarExpand);
    void setSizeItemInNavExpand(QSize sizeItemInNavExpand);
    void setSizeMain(QSize sizeMain);
    void setSizeHeader(QSize sizeHeader);    
    void setSizeImageView(QSize sizeImageView);    
    void setSizeImageViewRelative(QSize sizeImageViewRelative);

signals:
    void sizeNavBarChanged(QSize sizeNavBar);
    void sizeDisplayChanged(QSize sizeDisplay);
    void sizeIconMenuChanged(int sizeIconMenu);
    void sizeNavBarExpandChanged(QSize sizeNavBarExpand);
    void sizeItemInNavExpandChanged(QSize sizeItemInNavExpand);
    void sizeMainChanged(QSize sizeMain);
    void sizeHeaderChanged(QSize sizeHeader);    
    void sizeImageViewChanged(QSize sizeImageView);    
    void sizeImageViewRelativeChanged(QSize sizeImageViewRelative);

private:
    QSize m_sizeNavBar;
    QSize m_sizeDisplay;
    int m_sizeIconMenu;
    QSize m_sizeNavBarExpand;
    QSize m_sizeItemInNavExpand;
    QSize m_sizeMain;
    QSize m_sizeHeader;
    QSize m_sizeImageView;
    QSize m_sizeImageViewRelative;
};

#endif // PROPERTIES_H
