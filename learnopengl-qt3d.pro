QT += 3dcore 3drender 3dinput 3dquick qml quick quickcontrols2 3dquickextras sensors charts

CONFIG += c++11

SOURCES += main.cpp

RESOURCES += app.qrc \
    assets.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

OTHER_FILES += qml/*.qml

DISTFILES += \
    qml/app-cpp.qml
