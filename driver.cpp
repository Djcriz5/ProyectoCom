#include "driver.h"
#include "parser.tab.hh"

int analizador_driver::parse(const std::string& archivo)
{
  file = archivo;  
  iniciarScanner();
  yyout = fopen("TankManager.cs","w");//
  fprintf(yyout,"using System; using UnityEngine; namespace Complete{[Serializable] public class TankManager {public Color m_PlayerColor;public Transform m_SpawnPoint;[HideInInspector]public int m_PlayerNumber;[HideInInspector]public string m_ColoredPlayerText;[HideInInspector]public GameObject m_Instance;[HideInInspector]public int m_Wins;private TankHealth m_Health;private TankMovement m_Movement;private TankShooting m_Shooting;private GameObject m_CanvasGameObject;public void Setup(){ System.Random ran = new System.Random();float random = ran.Next(1,200);m_Health=m_Instance.GetComponent<TankHealth>();m_Movement=m_Instance.GetComponent<TankMovement>();m_Shooting=m_Instance.GetComponent<TankShooting>();m_CanvasGameObject=m_Instance.GetComponentInChildren<Canvas>().gameObject;m_Movement.m_PlayerNumber=m_PlayerNumber;m_Shooting.m_PlayerNumber=m_PlayerNumber;");
  yy::analizador_parser parser(*this);
  parser.set_debug_level(false);
  float resultado = parser.parse();
  terminarScanner();
  fprintf(yyout,"m_ColoredPlayerText=\"<color=#\"+ColorUtility.ToHtmlStringRGB(m_PlayerColor)+\">PLAYER \"+m_PlayerNumber+\"</color>\";MeshRenderer[]renderers=m_Instance.GetComponentsInChildren<MeshRenderer>();for(int i=0;i<renderers.Length;i++){renderers[i].material.color=m_PlayerColor;}}public void DisableControl(){m_Movement.enabled=false;m_Shooting.enabled=false;m_CanvasGameObject.SetActive(false);}public void EnableControl(){m_Movement.enabled=true;m_Shooting.enabled=true;m_CanvasGameObject.SetActive(true);}public void Reset(){m_Instance.transform.position=m_SpawnPoint.position;m_Instance.transform.rotation=m_SpawnPoint.rotation;m_Instance.SetActive(false);m_Instance.SetActive(true);}}}");
  fclose(yyout);  //  
  return resultado;
}
