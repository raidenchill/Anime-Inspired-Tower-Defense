# Untitled Tower Defense

Anime-character tower-defense framework with portals, summons, economy units, traits, and server validation.

Example roster: Speedwagon, Bulma, Nami, Tanjiro, Naruto, Luffy, Ichigo, Goku, Gojo, and Sakura.

Money units:
- Speedwagon: passive income
- Bulma: stronger passive income
- Nami: income plus hybrid damage and chest-style bonus support

Traits:
- Untitled: 0.1% chance, +300% damage, -40% cooldown, +30% range, and 4x money generation on economy units
- Golden: +20% income
- Fortune: +35% income
- Investor: +50% income with a damage tradeoff

Portals:
- Starter Portal
- Legendary Portal
- Single and 10x summons
- Server-side gem checks, weighted rolls, and inventory rewards

Studio setup:
1. Create a Baseplate experience named Untitled Tower Defense.
2. Copy ReplicatedStorage files into matching ModuleScripts.
3. Copy ServerScriptService files into matching Scripts.
4. Build your unit placement system around UnitDefinitions.
5. Build portal UI around ReplicatedStorage.PortalSummon.
6. Apply traits server-side to damage, cooldown, range, and income.

Important: use anime character names/assets only when you have the necessary rights or licenses. This repo provides gameplay architecture and does not include protected anime models, animations, sounds, maps, UI, or proprietary game code.
