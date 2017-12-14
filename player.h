#ifndef PLAYER_PLAYER_H
#define PLAYER_PLAYER_H


#include <string>

class Player {
public:
    const std::string getParametros() ;

    void setParametros(const std::string &parametros);

public:
     std::string parametros;


};


#endif //PLAYER_PLAYER_H
