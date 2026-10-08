# Configuration

Configuring Views Advanced Routing is a two‑stage process: enable the display
extender once for the whole site, then set route YAML on each display you want to
customize.

## 1. Enable the display extender (once, site‑wide)

1. Log in as a user with the **Administer views** permission.
2. Go to **Structure → Views → Settings → Advanced**
   (`/admin/structure/views/settings/advanced`).
3. In the **Display extenders** section, tick **Route**.
4. Save.

This makes the extra Route settings available to your Views. You only do this
once.

## 2. Set route YAML on a display

1. Edit a View that has a **page** or **feed** display under **Structure →
   Views**.
2. In the middle column of the display settings (just below the Page/Access
   settings) a **Route** row now appears. Click it.
3. You'll get three textareas, each mirroring the same‑named section of a normal
   `*.routing.yml` entry — paste the values directly, without the top‑level keys:

   - **Defaults** — extra default parameters/controller arguments for the route.
   - **Requirements** — constraints the request must meet, for example an access
     check like `_permission: 'access content'` or a regular expression on a path
     parameter.
   - **Options** — route options such as `_admin_route: TRUE`, or the
     `parameters` block that attaches an entity parameter converter.

Each block is validated as YAML and test‑built into a real Symfony Route when you
save, so mistakes are caught early. The settings are stored inside the View
config entity, so they export and deploy along with the View.

### Example — upcast a path parameter into an entity

Set the display's **Path** (using Views' normal Path field) to something like
`node/%node/my_view`, then put this in the **Options** block:

```yaml
parameters:
  node:
    type: 'entity:node'
```

Now `%node` in the path is converted into a fully loaded Node object, exactly as
it would be for a hand‑written route.

## A reminder on power and trust

Because these three blocks map straight onto the underlying route, an
*Administer views* user editing them wields the same power as someone editing a
`routing.yml` file — including access requirements. Grant *Administer views* only
to people you trust with that level of control.
