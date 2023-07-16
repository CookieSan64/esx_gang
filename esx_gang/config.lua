Config = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 20
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 150, g = 250, b = 104 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = true
Config.EnableLicenses             = true
Config.MaxInService               = -1
Config.Locale                     = 'fr'

Config.GangStations = { -- Remplace 'GangStations' par la fonction qui ouvre le menu des actions du gang
  Gang = { -- Remplace 'Gang' par le nom du groupe criminel
    Vehicles = {
      {
        Spawner    = { x = 1117.752, y = -2277.266, z = 30.23565 },
        SpawnPoint = { x = 1112.389, y = -2286.195, z = 30.35929 },
        Heading    = 91.59446,
      }
    },
    VehicleDeleters = {
      { x = 1114.246, y = -2294.292, z = 30.54764 },
    }
  }
}