global function PureMode_Init
global function PureMode_Changes

void function PureMode_Init()
{
    Riff_ForceBoostAvailability(eBoostAvailability.Disabled)
    Riff_ForceTitanAvailability(eTitanAvailability.Never)

    AddCallback_OnPlayerRespawned(OnPlayerRespawned)
    AddCallback_OnPlayerGetsNewPilotLoadout(OnPlayerGetsNewPilotLoadout)
}

void function OnPlayerRespawned(entity player)
{
    player.SetAimAssistAllowed(false)
    RemoveNonPrimaryWeapons(player)
}

void function OnPlayerGetsNewPilotLoadout(entity player, PilotLoadoutDef loadout)
{
    RemoveNonPrimaryWeapons(player)
}

const array<string> ALLOWED_WEAPONS = [
    // primaries
    "mp_weapon_car",
    "mp_weapon_alternator_smg",
    "mp_weapon_hemlok_smg",
    "mp_weapon_r97",
    "mp_weapon_hemlok",
    "mp_weapon_vinson",
    "mp_weapon_g2",
    "mp_weapon_rspn101",
    "mp_weapon_rspn101_og",
    "mp_weapon_esaw",
    "mp_weapon_lstar",
    "mp_weapon_lmg",
    "mp_weapon_shotgun",
    "mp_weapon_mastiff",
    "mp_weapon_dmr",
    "mp_weapon_sniper",
    "mp_weapon_doubletake",
    "mp_weapon_pulse_lmg",
    "mp_weapon_smr",
    "mp_weapon_softball",
    "mp_weapon_epg",
    "mp_weapon_shotgun_pistol",
    "mp_weapon_wingman_n",

    // tacticals
    "mp_ability_grapple",
    "mp_ability_heal",
    "mp_ability_holopilot",
    "mp_ability_shifter",
    "mp_ability_cloak",
    "mp_weapon_deployable_cover",
    "mp_weapon_grenade_sonar"
]

void function RemoveNonPrimaryWeapons(entity player)
{
    array<entity> weapons = player.GetMainWeapons()
    weapons.extend(player.GetOffhandWeapons())

    foreach (entity weapon in weapons) {
        if (!ALLOWED_WEAPONS.contains(weapon.GetWeaponClassName())) {
            player.TakeWeaponNow(weapon.GetWeaponClassName())
        }
    }
}

array<string> function PureMode_Changes()
{
    return [
        "only primary weapons and tacticals"
        "no sidearms, no titans, no titan weapons, no throwables, no boosts, no melee, no aim assist"
    ]
}
