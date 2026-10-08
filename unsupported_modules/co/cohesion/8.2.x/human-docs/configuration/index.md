# Configuration

Site Studio needs three things before it can build pages: your **Acquia API
credentials**, an initial **import** of the base definitions, and a **rebuild** of
the generated assets. After that, the day-to-day configuration happens visually in
the Site Studio admin section.

## 1. Enter the Acquia API key

Site Studio is a commercial Acquia product, and its build service (the thing that
compiles your components and styles into CSS and Twig) requires a valid licence.

1. Log in as a user with the **Administer Site Studio** permission.
2. Go to the **Site Studio** admin section (under `/admin/cohesion`) and open the
   **Account settings** form.
3. Paste your **API key** and **agency key** (supplied by Acquia) and save.

The module stores this in the `cohesion.settings` configuration. Because the API
key is a secret, avoid committing it in a way that exposes it — prefer supplying it
through an environment variable or a Key entity where your workflow allows, and
keep it out of shared exported configuration.

> **Using DDEV?** You can store the key with DDEV's dotenv helper
> (`ddev dotenv set .ddev/.env --sitestudio-api-key=<value>`, keeping `.ddev/.env`
> out of version control, then `ddev restart`) and reference it from settings.

## 2. Import the definitions

On a **new environment**, run the import once to pull in the base Site Studio
definitions:

```bash
drush cohesion:import
```

## 3. Rebuild after every deploy

Site Studio's CSS and Twig templates are **generated artefacts, not
configuration**. Any time you deploy changes to Site Studio config, rebuild them:

```bash
drush cohesion:rebuild
```

Forgetting this step is the single most common Site Studio problem — the site runs
but the styling and templates are out of date. You can also tidy up leftover
entities with:

```bash
drush sitestudio:cleanup-orphans
```

## 4. Front-end and governance settings

Beyond the account settings, the base module also exposes front-end settings
(stored in `cohesion.frontend.settings`) that control aspects of how Site Studio
renders on the site. If you enabled `sitestudio_governance`, you can additionally
constrain which roles may edit which Site Studio entities — useful on larger teams
where editors should not be able to change global styles.

## 5. Build your site visually

With credentials in place and the import/rebuild done, the rest of Site Studio is
configured through its browser-based tools in the **Site Studio** section:
create **components**, define **styles** and a **style guide**, build
**templates**, and set **website settings** such as colours and fonts. If you
enabled `sitestudio_page_builder`, editors can assemble pages with the in-page
drag-and-drop editor.

## Permissions

Site Studio ships a large permission set — including `administer cohesion`,
`administer cohesion settings` (which is access-restricted), and
`administer front end settings`. Grant these only to trusted site builders, since
they control the site's entire design system.
