*** Settings ***
Documentation    Alfresco Project Gr.281
#Library    SeleniumLibrary 
Library    DateTime  
Library    Selenium2Library    
      
      
    

*** Variables ***
${TIMEOUT}                  8s 
${vURL}                     http://localhost:8020/share/page/     # for the college we should use this address : http://10.241.4.25/share/page/
${vNomSite}                 JiS       
${vBrowser}                 chrome
${vUsername}                1995536
${vPassword}                87654321
${vTitle}                   Alfresco » Login     # Alfresco » Connexion (for college)
${vNomGroupe}               xxxNomGroupeToBeConfirmedxxx
${vIdentifiantGroupe}       xxxidGroupeToBeConfirmedxxx
${vNomTacheReplique}        tache_281




*** Test Cases ***
   

Alfresco Project Gr.281 Script_1 Ajouter Module Wiki sur site
        # se connecter a  l'application Alfresco
    login    ${vURL}    ${vBrowser}    ${vUsername}    ${vPassword}    ${vTitle}          #(confirmed by Talel)
        # Ajouter Module Wiki sur site                                                        (confirmed)
    Ajouter Module Wiki sur site        ${vNomSite}
        # Fermer le navigateur
    Logout                                                                                #(confirmed by Talel)
    
Alfresco Project Gr.281 Script_2 Creer Tache Replication
        # se connecter Ã  l'application Alfresco
   login    ${vURL}    ${vBrowser}    ${vUsername}    ${vPassword}    ${vTitle}          #(confirmed by Talel)
        # Creer Tache Replication                                                             (confirmed)
   Creer Tache Replication    ${vNomTacheReplique} 
        # Fermer le navigateur
   Logout                                                                                #(confirmed by Talel)
    
Alfresco Project Gr.281 Script_3 Creer Groupe
        # se connecter Ã  l'application Alfresco
   Login    ${vURL}    ${vBrowser}    ${vUsername}    ${vPassword}    ${vTitle}          #(confirmed by Talel)
        # Creer Groupe                                                                        (confirmed)
   Creer Groupe    ${vIdentifiantGroupe}    ${vNomGroupe}
        # Fermer le navigateur
   Logout                                                                                #(confirmed by Talel)


*** Keywords ***

Ajouter Module Wiki sur site
    [Arguments]                      ${vNomSite}
    # Dans le localisateur de site, il faut ecrire le nom du site en minuscule 
    #Convert To Lowercase             ${vNomSiteMinuscul}    
    # Cliquer sur le menu "Sites"   
    Click Element                    xpath://*[@id="HEADER_SITES_MENU_text"]  
    # Sleep
    Set Selenium Timeout             ${TIMEOUT} 
    # Sleep
    Sleep    3s
    # Cliquer sur chercher un site pour trouver mon site
    Click Link                    xpath://*[@id="HEADER_SITES_MENU_SITE_FINDER_text"]/a   
    # Sleep
    Sleep    3s
    # Saisir le nom de mon site dans le champ
    Input Text                       id=template_x002e_site-finder_x002e_site-finder_x0023_default-term            ${vNomSite}
    # Cliquer sur la cle "chercher"
    Click Button                     id=template_x002e_site-finder_x002e_site-finder_x0023_default-button-button   
    # Sleep
    Sleep    3s     
    # Cliquer sur le nom du site 
    Click Element                    xpath:/html/body/div[3]/div[1]/div[2]/div/div/div/div[2]/div[2]/table/tbody[2]/tr/td[2]/div/h3/a  
    # Sleep
    Sleep    3s 
    # Attendre jusqu'a  l'affichage du nom du site)
    Wait Until Element Is Visible        id=HEADER_TITLE         
    # Sleep
    Sleep    3s 
    # Cliquer sur le sign d'option de configuration de site en haut a droite    
    Click Element                    xpath://*[@id="HEADER_SITE_CONFIGURATION_DROPDOWN"]/img    
    # Cliquer sur le lien "Personnaliser le site"   
    Click Element                    xpath://*[@id="HEADER_CUSTOMIZE_SITE_text"]/a
    # Attendre jusqu'à l'affichage de la page "Personnaliser le site"
    Wait Until Element Is Visible    xpath://*[@id="alf-hd"]/h1        
    # Ajouter le module wiki au site "JiS"
    Drag And Drop                    xpath://*[@id="template_x002e_customise-pages_x002e_customise-site_x0023_default-page-wiki-page"]/img     xpath://*[@id="template_x002e_customise-pages_x002e_customise-site_x0023_default-currentPages-ul"]
    # Cliquer sur "OK"
    Click Element                    xpath://*[@id="template_x002e_customise-pages_x002e_customise-site_x0023_default-save-button-button"]    
    # Sleep
    Sleep    3s   
    # Cliquer sur le module "Wiki"
    Click Element                    xpath://*[@id="HEADER_SITE_WIKI-PAGE_text"]/a   
    # Sleep
    Sleep    3s
    # Verifier le module "Wiki"
    Page Should Contain Element       xpath://*[@id="template_x002e_toolbar_x002e_wiki-page_x0023_default-body"]/div[1]/div/span/a        Wiki Page List  
    


    # Post-condition : Enlever le module "Wiki" du site "JiS" et remettre a sa place originale
    # Cliquer sur le sign d'option de configuration de site en haut a droite    
    Click Element                    xpath://*[@id="HEADER_SITE_CONFIGURATION_DROPDOWN"]/img    
    # Cliquer sur le lien "Personnaliser le site"   
    Click Element                    xpath://*[@id="HEADER_CUSTOMIZE_SITE_text"]/a
    # Attendre jusqu'à l'affichage de la page "Personnaliser le site"
    Wait Until Element Is Visible    xpath://*[@id="alf-hd"]/h1
    # Remettre le module "Wiki" a sa place originale (L'enlever du site "JiS")
    # Cliquer sur "Remove"
    Click Element                    xpath:/html/body/div[4]/div[1]/div[2]/div/div/div/div[5]/ul/li[3]/div[2]/a[2]    
    # Sleep
    Sleep    3s
    # Cliquer sur "OK"
    Click Element                    xpath://*[@id="template_x002e_customise-pages_x002e_customise-site_x0023_default-save-button-button"]        
    # Sleep
    Sleep    3s
    # Attendre jusqu'à l'affichage de la page du site "JiS"
    Wait Until Element Is Visible    xpath://*[@id="HEADER_TITLE"]/span/a
    # Sleep
    Sleep    3s
    # Verifier et confirmer l'absence du module "Wiki" sur le site "JiS"
    Page Should Not Contain Link     id=HEADER_SITE_WIKI-PAGE     
 
    
Creer Tache Replication
    [Arguments]    ${vNomTacheReplique} 
    # Cliquer sur "Outils admin"
    Click Element                    xpath://*[@id="HEADER_ADMIN_CONSOLE_text"]/a  
    # Sleep
    Sleep    5s
    # Vérifier l'ouverture de la page "Outil admin"    
    Element Text Should Be           xpath://*[@id="HEADER_TITLE"]/span     Admin Tools    # Outils admin (pour la vesion francaise d'Alfresco)  
    # Cliquer sur "Taches de replication"
    Click Element                    xpath://*[@id="page_x002e_tools_x002e_admin-console_x0023_default-body"]/ul[2]/li/span/a     
    # Sleep
    Sleep    3s
    # Cliquer sur "Creer une tache"
    Click Element                    xpath://*[@id="page_x002e_ctool_x002e_admin-console_x0023_default-create-button"] 
    # Sleep
    Sleep    3s
    # Vérifier l'ouverture de la page de "Créer une tâche de réplication"
    Wait Until Page Contains         Create New Replication Job     # Créer une tâche de réplication (pour la vesion francaise d'Alfresco) 
    # Saisir des donnes du nom désiré de tache
    Input Text                       xpath://*[@id="template_x002e_replication-job_x002e_replication-job_x0023_default-prop_name"]     ${vNomTacheReplique}    
    # Cliquer sur le button "Creer une tache" pour confirmer la création de la page Replication
    Click Element                    xpath://*[@id="template_x002e_replication-job_x002e_replication-job_x0023_default-form-submit-button"]
   # Sleep
    Sleep    5s
    # Vérifier la création de la page Replication   
    Element Text Should Be           xpath://*[@id="page_x002e_ctool_x002e_admin-console_x0023_default-jobDetail"]/h2                  ${vNomTacheReplique} 
    
        # Post condition
        # Supprimer la tache ${vNomTacheReplique} 
    #Click Element                    xpath://*[@id="page_x002e_ctool_x002e_admin-console_x0023_default-delete-button"]               
        # Sleep
    #Sleep    3s
        # Cliquer sur le button "Supprimer" pour confirmer alert
    #Click Button                     id=yui-gen18-button       
    
        # Critere de succes   
        # Verifier et confirmer l'absence de la tache ${vNomTacheReplique} dans la liste des taches
        # Cliquer sur "Outils admin"
    #Click Element                    xpath://*[@id="HEADER_ADMIN_CONSOLE_text"]/a
        # Cliquer sur "Taches de replication"
    #Click Element                    xpath://*[@id="page_x002e_tools_x002e_admin-console_x0023_default-body"]/ul[2]/li/span/a
        # Le nom de ${vNomTacheReplique} nr doit pas etre dans la liste des taches
    #Page Should Not Contain          ${vNomTacheReplique}    
    

Creer Groupe
    [Arguments]    ${vIdentifiantGroupe}    ${vNomGroupe}
    # Cliquer sur "Outils admin"
    Click Element                    xpath://*[@id="HEADER_ADMIN_CONSOLE_text"]/a 
    # Vérifier l'ouverture de la page "Outil admin"    
    Element Text Should Be           xpath://*[@id="HEADER_TITLE"]/span    Admin Tools    # Outils admin (pour la vesion francaise d'Alfresco)    
    # Cliquer sur "Groupes" à droite de la page
    Click Element                    xpath://*[@id="page_x002e_tools_x002e_admin-console_x0023_default-body"]/ul[3]/li[1]/span/a 
    # Sleep
    Sleep    3s
    # Cliquer sur le boutton "Parcourir"
    Click Element                    xpath://*[@id="page_x002e_ctool_x002e_admin-console_x0023_default-browse-button-button"]    
    # Sleep
    Sleep    3s
    # Cliquer sur le sign (+) "Nouveau groupe"
    Click Element                     class=groups-newgroup-button
    # Sleep
    Sleep    5s
    # attendre jusqu'a l'affichage de la page de "Nouveau groupe"
    Wait Until Page Contains Element    xpath://*[@id="page_x002e_ctool_x002e_admin-console_x0023_default-create-shortname"]    
    # Saisir l'identifiant de groupe ${vIdentifiantGroupe}
    Input Text                       xpath://*[@id="page_x002e_ctool_x002e_admin-console_x0023_default-create-shortname"]      ${vIdentifiantGroupe}    
    # Saisir le nom du groupe ${vNomGroupe}
    Input Text                       xpath://*[@id="page_x002e_ctool_x002e_admin-console_x0023_default-create-displayname"]    ${vNomGroupe}  
    # Sleep
    Sleep    3s
    # Cliquer sur le boutton "Créer un groupe"
    Click Element                    xpath://*[@id="page_x002e_ctool_x002e_admin-console_x0023_default-creategroup-ok-button-button"] 
    # Sleep
    Sleep    3s
    
    
    # Vérifier la création du groupe
    Element Text Should Be           xpath://*[@id="page_x002e_ctool_x002e_admin-console_x0023_default-search"]/div[1]/div[1]/div/label    Groups     # Groupes (pour la vesion francaise d'Alfresco)         
    # Chercher l'identifiant du groupe créé
    Input Text                       xpath://*[@id="page_x002e_ctool_x002e_admin-console_x0023_default-search-text"]    ${vIdentifiantGroupe}    
    # Cliquer sur le boutton "Rechercher"
    Click Element                    xpath://*[@id="page_x002e_ctool_x002e_admin-console_x0023_default-search-button-button"] 
    # Sleep
    Sleep    3s
    # Vérification l'existance du groupe
    Element Should Contain           xpath:/html[1]/body[1]/div[9]/div[1]/div[2]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[4]/div[2]/table[1]/tbody[2]/tr[1]/td[1]/div[1]        ${vIdentifiantGroupe}       
    
        # Post condition
        # supprimer le groupe ${vIdentifiantGroupe}
    #Click Element                    class=delete 
        # Sleep
    #Sleep    2s
        # Confirmer la suppression du groupe ${vIdentifiantGroupe}
    #Click Element                    xpath:/html/body/div[4]/div[1]/div[2]/div[3]/span[1]/span/button  
    
        # Verifier la post-condition
        # Cliquer sur le boutton "Parcourir"
    #Click Element                    xpath://*[@id="page_x002e_ctool_x002e_admin-console_x0023_default-browse-button-button"]    
        # Sleep
    #Sleep    3s
        # Refresh la page
    #Clear Element Text               xpath://*[@id="page_x002e_ctool_x002e_admin-console_x0023_default-search-text"]
        # Chercher l'identifiant du groupe créé
    #Input Text                       xpath://*[@id="page_x002e_ctool_x002e_admin-console_x0023_default-search-text"]    ${vIdentifiantGroupe} 
        # Cliquer sur le boutton "Rechercher"
    #Click Element                    xpath://*[@id="page_x002e_ctool_x002e_admin-console_x0023_default-search-button-button"] 
        # Sleep
    #Sleep    3s  
        # Verifier le message
    #Element Should Contain           class=search-bar-text                    No results. Note that your search will only match group identifiers and not display names.
       
   

login
    # vURL contient l'adresse URL de la page web
    # vBrowser contient l'identifiant du navigateur cible
    # vUsername contient le login
    # vPassword contient le mot de passe
    # vTitle contient le titre de la page de login
    [Arguments]    ${vURL}    ${vBrowser}    ${vUsername}    ${vPassword}    ${vTitle}
    # DÃƒÂ©finir la valeur de timeout pour le cas de test
    Set Selenium Timeout    ${TIMEOUT}
    # Ouvrir le navigateur en prÃƒÂ©cisant l'URL et le navigateur
    Open Browser    ${vURL}    ${vBrowser}
    # Maximiser la fenÃƒÂªtre du navigateur
    Maximize Browser Window
    # VÃƒÂ©rification du titre de la page
    Title Should Be    ${vTitle}
    # Saisie du login
    Input Text                                           id=page_x002e_components_x002e_slingshot-login_x0023_default-username    ${vUsername}
    # Saisie du mot de passe
    Input Text                                           id=page_x002e_components_x002e_slingshot-login_x0023_default-password    ${vPassword}
    # Click sur le bouton Connexion
    Click Button                                         id=page_x002e_components_x002e_slingshot-login_x0023_default-submit-button
    # S'assurer que la page est chargÃƒÂ©ÃƒÂ©
    Wait Until Element Is Visible                        xpath://*[@id="HEADER_TITLE"]/span
    # S'assurer que l'utilisateur est connectÃƒÂ© et que le tableau de bord est affichÃƒÂ©
    Element Should Contain                               xpath://*[@id="HEADER_TITLE"]/span    Yaribakht Iman Dashboard    #Tableau de bord de (for the college)
    

    
Logout
    sleep                                                3s
    Click Element                                        id=HEADER_USER_MENU_POPUP
    Wait Until Element Is Visible                        id=HEADER_USER_MENU_LOGOUT_text
    Click Element                                        id=HEADER_USER_MENU_LOGOUT_text
    [Teardown]    Close Browser
    


Select mode
    # vMode est le mode de colonne affichÃƒÂ© pour contenir les dashlets. Ce paramÃƒÂ¨tre peut avoir l'une des valeurs suivantes :
    # -1-column-button
    # -2-columns-wide-right-button
    # -2-columns-wide-left-button
    # -3-columns-button
    # -4-columns-button
    [Arguments]    ${vMode}
    sleep                                                2s
    #Click sur la roue dentee
    Click Element                                        xpath=//div[2]/div/div/div/div/img
    #Click sur le bouton "Changer la disposition"
    Click Element                                        id=template_x002e_customise-layout_x002e_customise-user-dashboard_x0023_default-change-button-button
    #Click sur le bouton "SÃƒÂ©lectionner" dans le frame Une colonne
    Run Keyword And Ignore Error    Click Element        id=template_x002e_customise-layout_x002e_customise-user-dashboard_x0023_default-select-button-dashboard    ${vMode}
    #Click sur le bouton "Ok"
    Run Keyword And Ignore Error    Click Element        id=template_x002e_customise-dashlets_x002e_customise-user-dashboard_x0023_default-save-button-button
    

