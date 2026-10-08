# Configuration

Achievements has two sides: a settings form and a per-user experience for the
front end, plus a developer API for defining and awarding achievements.

## Open the settings form

1. Log in as a user with the appropriate administration permission.
2. Open the Achievements settings form (`achievements.settings`) from the site's
   configuration pages.

The settings form controls the module's general behaviour — how achievements are
presented and how the framework behaves site-wide.

## Defining achievements

Achievements are defined so the module knows what can be unlocked and how many
points each is worth. Simple, milestone-style achievements can be set up through the
site's configuration; more specialized ones are defined in code. Each achievement
has its identity (title, description, an image/badge, and a point value) and a rule
for when it is awarded.

## Awarding achievements

Achievements are awarded to a user when they hit the milestone the achievement
represents. For built-in milestones this happens automatically; for anything
custom, a developer awards the achievement from their own code or event handler at
the moment the milestone is reached. Progress is tracked per user.

## Leaderboards and the per-user page

Out of the box the module provides:

- **Leaderboards** as two Views — `achievement_totals` (overall points) and
  `achievement_unlocks` (recent unlocks). Because these are Views, you can edit
  them, and you control who can see them through the View's access settings.
- **A per-user achievements page** showing what each user has unlocked.

## Privacy consideration

Leaderboards and the per-user pages can reveal usernames and activity. Before
exposing them broadly, decide who should be able to see them and set the access on
the leaderboard Views and the user pages accordingly.
