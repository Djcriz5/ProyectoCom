%skeleton "lalr1.cc" /* -*- C++ -*- */
%require "3.0.2"
%defines
%define parser_class_name {analizador_parser}
%define api.token.constructor
%define api.namespace {yy}
%define api.value.type variant
%define parse.assert
%code requires
{
#include <string>
#include <stdio.h>
class analizador_driver;
}
%param { analizador_driver& driver }
%locations
%define parse.trace
%define parse.error verbose
%code
{
#include "driver.h"
#include "player.h"

#include <iostream>
#include <vector>

using namespace std;
std::vector<Player> v;
int contador=0;

}

//Listadode Terminales
%token BracketDer "}"
%token BracketIz "{"
%token DPunto ":"
%token Coma ","
%token <std::string>TKN_Random 
%token TKN_Enemy 
%token <std::string> TKN_Identificador 
%token <std::string> TKN_palabraReservada 
%token <std::string> TKN_Integer 
%token <std::string> TKN_Decimal
%token FIN  0 "eof"
//Listado de No Terminales

//%printer { yyoutput << $$; } <*>;
%%
%start definicion;

definicion: listaDefinicion definicion ;

listaDefinicion :definicion;

definicion : TKN_Enemy TKN_Identificador cuerpo {
   Player p = Player();
    contador++;
    v.resize(contador);
    v[contador-1]=p;
   };
cuerpo : "{" expresion "}";

expresion :  listaExpresion expresion;

listaExpresion : expresion;

expresion : TKN_palabraReservada ":" TKN_Random ","{
  if(strcmp("attackspeed",$1.c_str())==0){
       //v.at(contador).parametros.append("m_Shooting.m_MaxChargeTime = " + $3 + ";\n");
      fprintf(driver.yyout,"m_Shooting.m_MaxChargeTime = %s;",$3.c_str());
      fprintf(driver.yyout,"\n");
  }else if(strcmp("movementspeed",$1.c_str())==0){
    //v.at(0).parametros.append("m_Movement.m_Speed = " + $3 + ";\n");
      fprintf(driver.yyout,"m_Movement.m_Speed = %s;",$3.c_str());
      fprintf(driver.yyout,"\n");
  }else if(strcmp("maxhealt",$1.c_str())==0){
    //v.at(0).parametros.append("m_Health.m_StartingHealth = " + $3 + ";\n");
      fprintf(driver.yyout," m_Health.m_StartingHealth = %s;",$3.c_str());
      fprintf(driver.yyout,"\n");
  }else{
    fprintf(driver.yyout,";\n");
  }
 

}
            |TKN_palabraReservada ":" TKN_Integer ","{
 if(strcmp("attackspeed",$1.c_str())==0){
      fprintf(driver.yyout,"m_Shooting.m_MaxChargeTime = %s",$3.c_str());
      fprintf(driver.yyout,"f;\n");
  }else if(strcmp("movementspeed",$1.c_str())==0){
      fprintf(driver.yyout,"m_Movement.m_Speed = %s",$3.c_str());
      fprintf(driver.yyout,"f;\n");
  }else if(strcmp("maxhealt",$1.c_str())==0){
      fprintf(driver.yyout," m_Health.m_StartingHealth = %s",$3.c_str());
      fprintf(driver.yyout,"f;\n");
  }else{
    fprintf(driver.yyout,"\n");
  }

            }
            |TKN_palabraReservada ":" TKN_Decimal ","{
if(strcmp("attackspeed",$1.c_str())==0){
      fprintf(driver.yyout,"m_Shooting.m_MaxChargeTime = %s",$3.c_str());
      fprintf(driver.yyout,"f;\n");
  }else if(strcmp("movementspeed",$1.c_str())==0){
      fprintf(driver.yyout,"m_Movement.m_Speed = %s",$3.c_str());
      fprintf(driver.yyout,"f;\n");
  }else if(strcmp("maxhealt",$1.c_str())==0){
      fprintf(driver.yyout," m_Health.m_StartingHealth = %s",$3.c_str());
      fprintf(driver.yyout,"f;\n");
  }else{
    fprintf(driver.yyout,";\n");
  }

};
%%
void yy::analizador_parser::error(const location_type& lugar, const std::string& lexema)
{
  std::cout << "Error Sintactico " << lexema << std::endl;
}
