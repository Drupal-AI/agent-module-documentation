# Configuration

Lytics configuration has three parts: connecting your account, tuning the
JavaScript tag, and building the personalization pieces (widgets and the
recommendation block).

## Store the Access Token safely

Your Lytics **Access Token** is an account credential. Keep it out of version
control — store it in an environment variable and, ideally, load it through a
mechanism that keeps it out of exported configuration. On this project the DDEV
dotenv pattern is:

```bash
ddev dotenv set .ddev/.env --lytics-access-token=<your-token>
ddev restart
```

That makes `LYTICS_ACCESS_TOKEN` available inside the web container (keep
`.ddev/.env` out of version control).

> **Note on how the token is stored and disclosed.** The module stores the token
> in the `lytics.settings` configuration and, on the widget‑manager screen,
> embeds it into the page HTML for users holding **manage lytics connection**.
> Because of that, grant **manage lytics connection** only to trusted
> administrators, and keep the token out of any configuration you commit or share.

## Connect your Lytics account

1. Go to **Configuration → System → Lytics** (`/admin/config/system/lytics`). You
   need the **manage lytics connection** permission.
2. Paste your Lytics **Access Token** and save. The module calls the Lytics
   account API and stores your resolved **account name, id, and domain**.

## Tag settings

On the same form you control how the Lytics JavaScript tag behaves:

- **Enable Tag** — turn the Lytics tag on. When enabled, the tag is injected on
  non‑admin pages so visitor behaviour is collected into Lytics profiles.
- **Debug Mode** — load the non‑minified version of the tag, which is easier to
  inspect while you are setting things up. Leave it off in production.
- **Ignore Admin Users** — exclude logged‑in admin users from tracking, so your
  own testing does not pollute the data.
- **Additional tag configuration (JSON)** — optionally supply extra tag
  configuration as raw JSON for advanced setups.

## Pathfora widgets

Manage personalization widgets at `/admin/structure/lytics_widgets/manage` (the
manage‑widgets permission is required). A wizard — driven by a custom
`lytics-widgetwiz` web component — walks you through building Pathfora widgets such
as modals, bars, and slide‑outs, and targeting them at Lytics **audiences
(segments)**, which are evaluated client‑side. Only **published** widgets render
on the site; drafts and paused widgets are skipped, so you can prepare a widget
without exposing it.

## Content Recommendation block

Place the **Lytics Content Recommendation** block through **Structure → Block
layout** to render per‑visitor recommendations. In the block's settings you can:

- choose the **interest engine** and **content collection** the recommendations
  draw from (these are fetched from the Lytics API server‑side);
- **limit** or **shuffle** how many recommendations appear;
- **include or exclude recently‑viewed content**.

## Dashboard

The module also surfaces a Lytics analytics view under **Reports** for users with
**view lytics dashboard**.
