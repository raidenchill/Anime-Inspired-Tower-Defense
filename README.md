# Anime-Inspired Tower Defense — Roblox Studio

An original anime-inspired tower-defense starter. It is **not a remake of Anime Adventures** and does not include its copyrighted characters, maps, animations, sounds, or assets.

## Roblox Studio installation

### 1. Create the project
Open Roblox Studio → **New → Baseplate**.

### 2. Create folders
In Explorer, create:

```text
ServerScriptService
├── GameConfig (ModuleScript)
├── PlayerData (Script)
└── AdminCommands (Script)

ReplicatedStorage
└── UnitDefinitions (ModuleScript)
```

Copy each matching file from `src/` into the corresponding Studio object.

### 3. Test
Click **Play**. Your player should receive:
- 500 Cash
- 100 Gems
- An Inventory folder

### 4. Raidenchill admin commands
The admin system checks the Roblox **UserId 334811058**, which is the `raidenchill` account configured for this project.

In the in-game chat, use:

```text
/give Cash 10000
/give Gems 5000
/give EmberSwordsman 1
/give StormArcher 1
/give VoidMage 1
/giveall
/cash 10000
/gems 5000
```

Only the configured UserId can run these commands. The commands affect the server-side values, so they are suitable for your own game rather than an executor/exploit.

### 5. Building the actual game
Next add these folders/systems:
- `Workspace.Map.PathNodes` — numbered enemy path parts
- `Workspace.Enemies` — spawned enemy models
- `Workspace.Towers` — placed towers
- `ReplicatedStorage.Remotes` — secure client/server RemoteEvents
- Tower placement validation on the server
- Enemy path movement
- Tower targeting and attacks
- Unit upgrades/evolutions
- Summoning/banner UI
- Lobby and matchmaking

## Recommended Studio security
Never trust the client with Cash, Gems, unit ownership, damage, or placement. Validate all of those on the server.

## Original-content requirement
Use your own original names, models, animations, maps, sounds, and artwork, or assets you have permission to use.
