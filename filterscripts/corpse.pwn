// Filterscript Corpses System
// by Edinson_Walker / EdinsonWalker.

#include < a_samp >
#include < zcmd >
#include < sscanf >

// New's
new actor[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("\n|=====================================|");
	print("       		Corpses System      	   ");
	print("|=====================================|\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	new Float: x_, Float: y_, Float: z_, Float: r_;
	actor[playerid] = playerid;
	GetPlayerPos(playerid, x_, y_, z_);
	GetPlayerFacingAngle(playerid, r_);
	actor[playerid] = CreateActor(GetPlayerSkin(playerid), x_, y_, z_, r_);
	SetActorVirtualWorld(actor[playerid], GetPlayerVirtualWorld(playerid));
	ApplyActorAnimation(actor[playerid], "PED", "FLOOR_hit_f", 4.1, 0, 1, 1, 1, 1); //
	SetTimerEx("borrar_a", 15000, false, "i", playerid); // 15000 = 15seg
	return 1;
}

forward borrar_a(playerid); public borrar_a(playerid)
{
	if (actor[playerid] != -1)
	{
		DestroyActor(actor[playerid]);
		actor[playerid] = -1;
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	actor[playerid] = -1;
}

// Opcional.
CMD:deletecorpse(playerid, params[])
{
	new id;
	if (!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1, "Not authorized to use this command.");
	if (sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "CMD: /deletecorpse [id]");
	if (actor[id] == -1) return SendClientMessage(playerid, -1, "* Player is not corpse.");
	DestroyActor(actor[id]);
	actor[id] = -1;
	return 1;
}
