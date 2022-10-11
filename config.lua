xFidelite = xFidelite  or {}

xFidelite = {
    RankAcces = {"mod", "admin", "superadmin", "_dev", "owner"}, -- Commande give
    TimeForAddPoint = 10, -- Temps en minute
    Gain = 10, -- Nombre de point qu'il reçoit
    NotificationGain = "(~y~Information~s~)\nVous avez gagné ~r~10~s~ points, merci pour votre fidélité sur ~r~xDev~s~.", -- Notification que l'on reçoit à chaque fois qu'on gagne des points
    NotificationGivePoint = "(~y~Information~s~)\nOn vous à give des points.", -- Notification que l'on reçoit quand on nous give des points
    -- Menu
    CommandForOpenMenu = "menufidelite",
    Banniere = "img_red", --Couleur de la banière : img_red, img_bleu, img_vert, img_jaune, img_violet, img_gris, img_grisf, img_orange
    CouleurMenu = "r",  --"r" = rouge, "b" = bleu, "g" = vert, "y" = jaune, "p" = violet, "c" = gris, "m" = gris foncé, "u" = noir, "o" = orange
    Boutique = {
        Item = { -- Itme dans la boutique
            {Label = "Pain", Price = 50, Name = "bread"},
            {Label = "Eau", Price = 50, Name = "water"},
            {Label = "Pistolet", Price = 10000, Name = "pistol"},
        },
        Car = {
            {Label = "Rebla", Price = 100000, Model = "rebla"},
        }
    }
}

--- Xed#1188 | https://discord.gg/HvfAsbgVpM