--[[
Romanian base language translation for qb-adminmenu
Translation done by wanderrer (Martin Riggs#0807 on Discord)
]]--
local Translations = {
    error = {
        ["blips_deactivated"] = "Blipuri dezactivate",
        ["names_deactivated"] = "Nume dezactivate",
        ["changed_perm_failed"] = "Alege un grup!",
        ["missing_reason"] = "Trebuie specificat un motiv!",
        ["invalid_reason_length_ban"] = "Trebuie specificat un motiv si durata banului!",
        ["no_store_vehicle_garage"] = "Nu poti parca acest vehicul in garajul tau..",
        ["no_vehicle"] = "Nu esti intr-un vehicul..",
        ["no_weapon"] = "Nu ai nicio arma in mana..",
        ["no_free_seats"] = "Acest vehicul nu mai are scaune disponibile!",
        ["failed_vehicle_owner"] = "Acest vehicul este deja al tau..",
        ["not_online"] = "Acest jucator nu este online/conectat",
        ["no_receive_report"] = "Nu mai primesti rapoarte",
        ["failed_set_speed"] = "Nu ai setat viteza.. (`fast` pentru super-viteza, `normal` pentru viteza normala)",
        ["failed_set_model"] = "Nu ai setat modelul..",
        ["failed_entity_copy"] = "Nu exista informatii despre enitatea targetata de copiat!",
        ["no_permissions"] = "You don't have permission to use this feature",
    },
    success = {
        ["blips_activated"] = "Blipuri activate",
        ["names_activated"] = "Numele activate",
        ["coords_copied"] = "Coordonatele au fost copiate cu succes!",
        ["heading_copied"] = "Orientarea a fost copiata cu succes!",
        ["changed_perm"] = "Grupul de permisiuni a fost schimbat",
        ["entered_vehicle"] = "A intrat in vehicul",
        ["success_vehicle_owner"] = "Acest vehicul este acum al tau!",
        ["receive_reports"] = "Primesti tichete acum (plangeri)",
        ["entity_copy"] = "Informatiile despre entitatea targetata au fost copiate!",
        ["sucess.entered_vehicle"] = "a intrat cu succes in vehicul",
        ["spawn_weapon"] = "Ai creat (spawn) o arma",
        ["noclip_enabled"] = "No-clip activat",
        ["noclip_disabled"] = "No-clip dezactivat",
    },
    info = {
        ["ped_coords"] = "Coordonatele PED-ului:",
        ["vehicle_dev_data"] = "Date despre vehicul:",
        ["ent_id"] = "ID-ul enititatii:",
        ["net_id"] = "Net ID:",
        ["net_id_not_registered"] = "Neinregistrat",
        ["model"] = "Model",
        ["hash"] = "Hash",
        ["eng_health"] = "Starea Motorului:",
        ["body_health"] = "Starea Caroseriei:",
        ["goto"] = "Mergi la",
        ["remove"] = "Sterge",
        ["confirm"] = "Confirma",
        ["reason_title"] = "Motiv",
        ["length"] = "Durata",
        ["options"] = "Optiuni",
        ["position"] = "Pozitie",
        ["your_position"] = "la pozitia ta",
        ["open"] = "Deschide",
        ["inventories"] = "inventare",
        ["reason"] = "trebuie sa specifici un motiv",
        ["give"] = "ofera",
        ["id"] = "ID:",
        ["player_name"] = "Numele jucatorului",
        ["obj"] = "Obj",
        ["ammoforthe"] = "+%{value} munitie pentru %{weapon}",
        ["kicked_server"] = "Ai fost dat afara de pe server (kick)",
        ["check_discord"] = "🔸 Verifica te rog serverul de Discord pentru mai multe informatii: ",
        ["banned"] = "Ai primit BAN pe acest server:",
        ["ban_perm"] = "\n\nBAN-ul tau este permanent.\n🔸 Verifica Discordul nostru pentru mai multe informatii: ",
        ["ban_expires"] = "\n\nBAN-ul expira in: ",
        ["rank_level"] = "Nivelul tau de permisiuni este acum  ",
        ["admin_report"] = "Tichet Administrativ - ",
        ["staffchat"] = "STAFFCHAT - ",
        ["warning_chat_message"] = "^8AVERTISMENT ^7 Ai primit avertisment de la",
        ["warning_staff_message"] = "^8AVERTISMENT ^7 L-ai avertizat pe ",
        ["no_reason_specified"] = "Niciun motiv specificat",
        ["server_restart"] = "Se restarteaza serverul, verifica serverul nostru de Discord pentru mai multe informatii: ",
        ["entity_view_distance"] = "Distanta de vizualizare a entitatii este setata la: %{distance} metrii",
        ["entity_view_info"] = "Informatii despre entitate",
        ["entity_view_title"] = "Modul de targetare libera",
        ["entity_freeaim_delete"] = "Sterge entitate",
        ["entity_freeaim_freeze"] = "Blocheaza entitate",
        ["entity_frozen"] = "Blocat(a)",
        ["entity_unfrozen"] = "Deblocat(a)",
        ["model_hash"] = "Hash-ul modelului:",
        ["obj_name"] = "Numele obiectului:",
        ["ent_owner"] = "Proprietarul entitatii:",
        ["cur_health"] = "Sanatate curenta:",
        ["max_health"] = "Sanatate maxima:",
        ["armour"] = "Armura/vesta antiglont:",
        ["rel_group"] = "Grupul de relationare:",
        ["rel_to_player"] = "Relatia cu Jucatorul:",
        ["rel_group_custom"] = "Relatie Personalizata",
        ["veh_acceleration"] = "Acceleratie:",
        ["veh_cur_gear"] = "Viteza actuala:",
        ["veh_speed_kph"] = "Kph:",
        ["veh_speed_mph"] = "Mph:",
        ["veh_rpm"] = "Rpm:",
        ["dist_to_obj"] = "Dist:",
        ["obj_heading"] = "Orientare:",
        ["obj_coords"] = "Coordonate:",
        ["obj_rot"] = "Rotatie:",
        ["obj_velocity"] = "Viteza:",
        ["obj_unknown"] = "Necunoscut(a)",
        ["you_have"] = "Ai ",
        ["freeaim_entity"] = " entitatea targetata",
        ["entity_del"]  = "Entitate stearsa",
        ["entity_del_error"] = "A aparut o eroare la stergerea entitatii",
    },
    menu = {
        ["admin_menu"] = "Meniu administrativ",
        ["admin_options"] = "Optiuni administrative",
        ["online_players"] = "Jucatori conectati",
        ["manage_server"] = "Gestionarea serverului",
        ["weather_conditions"] = "Optiuni meteo disponibile",
        ["dealer_list"] = "Lista dealerilor",
        ["ban"] = "Ban",
        ["kick"] = "Kick",
        ["permissions"] = "Nivel permisiuni",
        ["developer_options"] = "Optiuni developer",
        ["vehicle_options"] = "Optiuni vehicule",
        ["vehicle_categories"] = "Categorii vehicule",
        ["vehicle_models"] = "Modele vehicule",
        ["player_management"] = "Managementul jucatorilor",
        ["server_management"] = "Managementul serverului",
        ["vehicles"] = "Vehicule",
        ["noclip"] = "NoClip",
        ["revive"] = "Reinvie",
        ["invisible"] = "Invizibil",
        ["god"] = "Godmode",
        ["names"] = "Nume",
        ["blips"] = "Blipuri",
        ["weather_options"] = "Optiuni meteo",
        ["server_time"] = "Ora serverului",
        ["time"] = "Timpul/Ora",
        ["copy_vector3"] = "Copiaza vector3",
        ["copy_vector4"] = "Copiaza vector4",
        ["display_coords"] = "Afiseaza coordonatele",
        ["copy_heading"] = "Copiaza orientarea",
        ["vehicle_dev_mode"] = "Modul DEV pentru vehicule",
        ["spawn_vehicle"] = "Spawn Vehicle",
        ["fix_vehicle"] = "Repara vehicul",
        ["buy"] = "Cumpara",
        ["remove_vehicle"] = "Sterge vehicul",
        ["edit_dealer"] = "Editeaza dealerul ",
        ["dealer_name"] = "Numele dealerului",
        ["category_name"] = "Numele categoriei",
        ["kill"] = "Omoara",
        ["freeze"] = "Blocheaza",
        ["spectate"] = "Specteaza",
        ["bring"] = "Teleporteaza",
        ["sit_in_vehicle"] = "Aseaza in vehicul",
        ["open_inv"] = "Deschide inventar",
        ["give_clothing_menu"] = "Ofera meniul de haine",
        ["hud_dev_mode"] = "Modul DEV (qb-hud)",
        ["entity_view_options"] = "Modul de vizualizare entitati",
        ["entity_view_distance"] = "Seteaza distanta de vizualizare",
        ["entity_view_freeaim"] = "Modul de targetare",
        ["entity_view_peds"] = "Afiseaza NPC",
        ["entity_view_vehicles"] = "Afiseaza vehicule",
        ["entity_view_objects"] = "Afiseaza obiecte",
        ["entity_view_freeaim_copy"] = "Copiaza informatiile entitatii",
        ["spawn_weapons"] = "Spawneaza arme",
        ["max_mods"] = "Toate modulele vehiculului la maxim",
    },
    desc = {
        ["admin_options_desc"] = "Optiuni diverse pentru administratori",
        ["player_management_desc"] = "Vezi lista completa de jucatori",
        ["server_management_desc"] = "Optiuni diverse pentru server",
        ["vehicles_desc"] = "Optiuni disponibile pentru vehicule",
        ["dealer_desc"] = "Lista completa cu dealerii de droguri din stat",
        ["noclip_desc"] = "Activeaza/Dezactiveaza functia NoClip",
        ["revive_desc"] = "Te readuci la viata :)",
        ["invisible_desc"] = "Activeaza/Dezactiveaza functia de invizibilitate",
        ["god_desc"] = "Activeaza/Dezactiveaza modul invincibil",
        ["names_desc"] = "Activeaza/Dezactiveaza numele desupra capului jucatorilor",
        ["blips_desc"] = "Activeaza/Dezactiveaza pentru jucatori pe harta",
        ["weather_desc"] = "Optiuni pentru modificarea vremii pe server",
        ["developer_desc"] = "Optiuni diverse pentru developeri",
        ["vector3_desc"] = "Copiaza coordonatele vector3",
        ["vector4_desc"] = "Copiaza coordonatele vector4",
        ["display_coords_desc"] = "Afiseaza coordonatele curente pe ecran",
        ["copy_heading_desc"] = "Copiaza orientarea actuala",
        ["vehicle_dev_mode_desc"] = "Afiseaza informatii despre vehicule",
        ["delete_laser_desc"] = "Activeaza/Dezactiveaza functia laser",
        ["spawn_vehicle_desc"] = "Spaweaza un vehicul in/pe server",
        ["fix_vehicle_desc"] = "Repara complet vehiculul in care te afli",
        ["buy_desc"] = "Cumperi vehiculul fara bani :)",
        ["remove_vehicle_desc"] = "Sterge cel mai apropiat vehicul",
        ["dealergoto_desc"] = "Esti teleportat la dealer",
        ["dealerremove_desc"] = "Sterge un dealer de droguri",
        ["kick_reason"] = "Motivul pentru kick",
        ["confirm_kick"] = "Confirma kick-ul",
        ["ban_reason"] = "Motivul pentru ban",
        ["confirm_ban"] = "Confirma ban-ul",
        ["sit_in_veh_desc"] = "Aseaza-te langa",
        ["sit_in_veh_desc2"] = "in vehiculul sau",
        ["clothing_menu_desc"] = "Oferi meniul de haine lui",
        ["hud_dev_mode_desc"] = "Activeaza/Dezactiveaza modul Developer",
        ["entity_view_desc"] = "Vezi informatiile disponibile despre entitati",
        ["entity_view_freeaim_desc"] = "Activeaza/Dezactiveaza targetarea via freeaim",
        ["entity_view_peds_desc"] = "Activeaza/Dezactiveaza informatiile despre NPC din server",
        ["entity_view_vehicles_desc"] = "Activeaza/Dezactiveaza informatiile despre vehiculele din server",
        ["entity_view_objects_desc"] = "Activeaza/Dezactiveaza informatiile despre obiectele din server",
        ["entity_view_freeaim_copy_desc"] = "Copiaza informatiile entitatii targetate",
        ["spawn_weapons_desc"] = "Spawneaza orice tip de arma disponibila pe/in server",
        ["max_mod_desc"] = "Maximizarea tuturor modulelor vehiculului curent",
    },
    time = {
        ["ban_length"] = "Durata banului",
        ["1hour"] = "1 ora",
        ["6hour"] = "6 ore",
        ["12hour"] = "12 ore",
        ["1day"] = "1 zi",
        ["3day"] = "3 zile",
        ["1week"] = "1 saptamana",
        ["1month"] = "1 luna",
        ["3month"] = "3 luni",
        ["6month"] = "6 luni",
        ["1year"] = "1 an",
        ["permenent"] = "permanent",
        ["self"] = "Self",
        ["changed"] = "Ora a fost schimbata la %{time} hs 00 min",
    },
    weather = {
        ["extra_sunny"] = "Extra insorit",
        ["extra_sunny_desc"] = "Ne topim prietenas!",
        ["clear"] = "Cer clar",
        ["clear_desc"] = "Ziua perfecta pe bune!",
        ["neutral"] = "Neutru",
        ["neutral_desc"] = "O zi ca oricare alta!",
        ["smog"] = "Smog",
        ["smog_desc"] = "Fumeaza sau polueaza lumea!",
        ["foggy"] = "Cetos",
        ["foggy_desc"] = "Abia pot sa mai vad!",
        ["overcast"] = "Cer inorat",
        ["overcast_desc"] = "Nu ne atinge soarele!",
        ["clouds"] = "Fara soare",
        ["clouds_desc"] = "Ati ascuns soarele?",
        ["clearing"] = "Partial noros",
        ["clearing_desc"] = "Dispar norii incet dar sigur!",
        ["rain"] = "Ploaie",
        ["rain_desc"] = "Make It Rain!",
        ["thunder"] = "Tunete si fulgere",
        ["thunder_desc"] = "Vine Thor probabil!",
        ["snow"] = "Zapada",
        ["snow_desc"] = "Vine Craciunul?",
        ["blizzard"] = "Viscol",
        ["blizzed_desc"] = "Opriti zapada va rog!",
        ["light_snow"] = "Ninsoare usoara",
        ["light_snow_desc"] = "Simt spiritul Craciunului!",
        ["heavy_snow"] = "Ninsoare abundenta (XMAS)",
        ["heavy_snow_desc"] = "Bataie cu bulgari!",
        ["halloween"] = "Halloween",
        ["halloween_desc"] = "Ce e asta?!",
        ["weather_changed"] = "Vremea a fost schimbata cu: %{value}",
    },
    commands = {
        ["blips_for_player"] = "Afiseaza blipurile pentru jucatori (Doar pt. admini)",
        ["player_name_overhead"] = "Afiseaza numele jucatorilor deasupra capului (Doar pt. admini)",
        ["coords_dev_command"] = "Activeaza afisarea coordonatelor (Doar pt. admini)",
        ["toogle_noclip"] = "Activeaza/Dezactiveaza functia noclip (Doar pt. admini)",
        ["save_vehicle_garage"] = "Salveaza vehiculul curent in garajul tau (Doar pt. admini)",
        ["make_announcement"] = "Anunturi globale pe server (Doar pt. admini)",
        ["open_admin"] = "Deschide meniul administrativ (Doar pt. admini)",
        ["staffchat_message"] = "Trimiti mesaje catre staff-ul serverului (Doar pt. admini)",
        ["nui_focus"] = "Dai NUI Focus unui jucator(Doar pt. admini)",
        ["warn_a_player"] = "Avertizezi un jucator (Doar pt. admini)",
        ["check_player_warning"] = "Verifici daca un jucator a primir avertisment (Doar pt. admini)",
        ["delete_player_warning"] = "Stergi avertismentele unui jucator (Doar pt. admini)",
        ["reply_to_report"] = "Raspunzi unui tichet administrativ (Doar pt. admini)",
        ["change_ped_model"] = "Schimbi modelul PED-ului (Doar pt. admini)",
        ["set_player_foot_speed"] = "Setezi viteza cu care se deplaseaza un jucator (Doar pt. admini)",
        ["report_toggle"] = "Activezi/Dezactivezi primirea tichetelor administrative (Doar pt. admini)",
        ["kick_all"] = "Dai kick tuturor jucatorilor de pe server",
        ["ammo_amount_set"] = "Setezi cantitatea de munitie detinuta (Doar pt. admini)",
    }
}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
