# Configuration

Personalization Rule is configured entirely through its **visual rule builder**.
There is no single global settings screen to fill in before you start — instead
you create rules, each of which pairs the conditions that decide *when* it applies
with the actions that decide *what* it does.

## Open the rule builder

1. Log in as a user with permission to administer personalization rules.
2. From the admin menu, open the module's **rule management** listing. This shows
   all your existing rules and lets you **create**, **edit**, **enable**,
   **disable**, and **delete** them.
3. Click to add a new rule (or edit an existing one) to open the builder.

Each rule opens with a few tabs: a **Builder** tab where you assemble conditions,
an **Actions** tab for what the rule does, a **Settings** tab for the rule's own
options, and a **debug / preview** panel so you can check the rule before it goes
live. There is also a general settings tab for the rule set as a whole.

## Build the conditions

On the **Builder** tab you assemble the conditions that decide when the rule
fires. Conditions can be nested into groups and combined with **AND**, **OR**, and
**NOT** logic, so you can express things like "*mobile visitors from a campaign
referrer, but not logged‑in users*". Edit conditions inline and watch the live
preview update. The available conditions are:

- **User Role** — match visitors in specific roles.
- **User Login Status** — authenticated vs. anonymous.
- **Path** — the current page path.
- **Query String** — a parameter in the URL's query string.
- **Referrer** — the referring URL the visitor arrived from.
- **Device Type** — for example desktop vs. mobile.
- **Country** — the visitor's country.
- **Source** — the traffic/campaign source.
- **Time** — time‑based targeting.
- **Visited Path** — whether the visitor has previously visited a given path.

## Choose the actions

On the **Actions** tab, pick what the rule does when its conditions are met:

- **Show block** — reveal a block to the matching visitors.
- **Hide block** — hide a block from them.
- **Replace block** — swap one block for another.
- **Inject HTML snippet** — insert a piece of custom HTML (useful for
  campaign‑specific banners or markup).

When an action targets a block, you select the specific block it applies to.

## Preview, then enable

Use the **debug / preview** panel to confirm the rule matches the visitors you
expect and performs the right action, then set the rule to **enabled** on the rule
listing. Because rules are stored as configuration entities, you can export them
with your site's configuration and deploy them to other environments.

## Tips

- Start with a single, narrow rule (for example, "show a banner on one path") and
  confirm it behaves before layering on more conditions.
- Because actions can inject HTML, only trusted administrators should hold the
  permission to create and edit rules — treat an injected snippet as content that
  renders on your pages.
- Personalization that varies per visitor interacts with caching; if a rule
  doesn't seem to take effect, clear caches and re‑check the preview.
