Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 20
Config.MarkerSize                 = { x = 1.0, y = 2.0, z = 1.0 }
Config.MarkerColor                = { r = 100, g = 120, b = 155 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = true
Config.EnableLicenses             = true
Config.MaxInService               = -1
Config.Locale                     = 'fr'

Config.PariahStations = {

  Biker = {

    AuthorizedWeapons = {
    { name = 'WEAPON_COMBATPISTOL',     price = 4000 },
    { name = 'WEAPON_ASSAULTSMG',       price = 15000 },
    { name = 'WEAPON_ASSAULTRIFLE',     price = 25000 },
    { name = 'WEAPON_FLARE',            price = 8000 },
    { name = 'WEAPON_SWITCHBLADE',      price = 500 },
	  { name = 'WEAPON_REVOLVER',         price = 6000 },
	  { name = 'WEAPON_POOLCUE',          price = 100 },
	  
    },

	  AuthorizedVehicles = {
		  { name = 'BF400',    label = 'MotoCross' },
		  { name = 'bati',  label = 'Moto de Course' },
		  { name = 'chimera',     label = 'Moto 3 Roue' },
		  { name = 'speedo',     label = 'Cammionette' },
	  },

    Armories = {
    --  { x = 109.44, y = 3619.77, z = 40.49}, 
    },

    Vehicles = {
      {
        Spawner    = { x = 564.2045, y = -2792.112, z = 6.081367 }, 
        SpawnPoint = { x = 571.8365, y = -2800.308, z = 6.084874 }, 
        Heading    = 243.3577, 
      }
    },

    VehicleDeleters = {
      { x = 563.5856, y = -2800.153, z = 6.081938 }, 
    },

    BossActions = {
    --  { x = 101.72, y = 3619.33, z = 40.49 } 
    },

  },

}