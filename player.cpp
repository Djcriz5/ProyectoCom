//
// Created by cris castro on 13/12/17.
//

#include "player.h"

const std::string Player::getParametros()  {
    return parametros;
}

void Player::setParametros(const std::string &parametros) {
    Player::parametros = parametros;
}
