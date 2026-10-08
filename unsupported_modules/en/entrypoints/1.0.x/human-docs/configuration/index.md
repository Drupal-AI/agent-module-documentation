# Configuration

Entrypoints is configured through a settings form and a separate rebuild page,
both under `/admin/config/entrypoints`, and it is governed by three permissions.

## Permissions

Grant these under **People → Permissions**, keeping the last two tight:

- **View entrypoints config** (`view entrypoints config`) — read‑only access to
  the configuration page.
- **Edit entrypoints config** (`edit entrypoints config`) — change entrypoint
  definitions. **Marked restricted access** — grant only to trusted admins.
- **Rebuild entrypoints** (`rebuild entrypoints`) — trigger a build. **Marked
  restricted access** because rebuilding compiles projects by running a runtime
  (npm/yarn) on the server. Give this only to trusted operators.

## The settings form

Open **`/admin/config/entrypoints`** (the `entrypoints.settings_form`). This is
where you register and manage your **entrypoint definitions** — the mapping from
your bundler's manifest output to Drupal libraries — and choose the plugins that
back them:

- **Runtime** — which runtime plugin (npm or yarn) is used to build.
- **Renderer** — a renderer plugin (for example a node renderer) for custom
  output, including SSR.
- **Input handlers** — plugins that feed data into a build.

Viewing and editing this page are gated by the `view` and `edit entrypoints
config` permissions respectively.

## The rebuild workflow

Open **`/admin/config/entrypoints/rebuild`** to compile your entrypoints. This
page is gated by the restricted `rebuild entrypoints` permission because it runs
the configured runtime (npm/yarn) to build the projects — a privileged, trusted
operation rather than something exposed to ordinary users.

You can also run rebuilds from the command line using the module's **Drush
commands**, which is convenient in deployment pipelines.

## Attaching and rendering entrypoints

Once definitions are registered, use them like any Drupal library:

- Attach a built entrypoint to a **render array** as a library.
- Place it with the provided **Entrypoint block**.
- Let the **SSR** support server‑render an entrypoint into the HTML response.
