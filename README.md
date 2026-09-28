# Untitled Tower Defense

An original anime-inspired tower defense game framework for Roblox Studio.

## Traits

Units can roll traits through the server-side Trait Reroll system.

### Ultra-rare trait: Untitled

- **Displayed name:** Untitled
- **Roll chance:** 0.1%
- **Damage:** +300% (4x total damage)
- **Cooldown:** -40% (0.60x cooldown)
- **Range:** +30% (1.30x range)

Other starter traits include Focused, Swift, Powerful, Hunter, and Basic.

## Trait rerolls

Players start with 5 `TraitRerolls`. The server validates reroll requests and subtracts one reroll per attempt.

The RemoteFunction is:

```text
ReplicatedStorage.TraitReroll
```

Call it from a client UI with the unit name. The server performs the roll and returns the resulting trait.

## Roblox Studio setup

1. Create a new **Baseplate** project.
2. Rename the experience to **Untitled Tower Defense**.
3. In `ReplicatedStorage`, create a ModuleScript named `TraitDefinitions` and copy `src/ReplicatedStorage/TraitDefinitions.lua` into it.
4. In `ServerScriptService`, keep/create `GameConfig`, `PlayerData`, and `AdminCommands` and copy their matching files.
5. Create a Script named `TraitService` in `ServerScriptService` and copy `src/ServerScriptService/TraitService.server.lua` into it.
6. Test with **Play**. The player starts with 5 Trait Rerolls.
7. Build a UI with a unit selector and Reroll button that invokes `ReplicatedStorage.TraitReroll:InvokeServer(unitName)`.

## Applying trait stats to a tower

When a tower is created, read its unit's trait and apply:

```lua
finalDamage = baseDamage * trait.DamageMultiplier
finalCooldown = baseCooldown * trait.CooldownMultiplier
finalRange = baseRange * trait.RangeMultiplier
```

Keep the calculation on the server so clients cannot change their own trait bonuses.

All characters, names, maps, animations, sounds, and visual assets should be original or properly licensed.
