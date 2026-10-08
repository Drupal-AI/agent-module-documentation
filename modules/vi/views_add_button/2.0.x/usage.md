<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Add Button adds a configurable "add an entity" button to any View — as a header/footer **area** or as a **field** — that links to an entity's create form, checks create-access, and supports tokens from contextual filters, CSS classes, query strings and a destination parameter.

---

The module registers two Views handlers via `hook_views_data_alter()`: an **area** handler `views_add_button_area` and a **field** handler `views_add_button_field`, both surfaced in the Views UI as **"Global: Entity Add Button" / "Entity Add Button"**. Add one to a view's header, footer, or fields and configure: the target **Entity Type** (+ bundle, stored as `type: "<entity_type>+<bundle>"`), **Button Text**, **Button Classes** (to render the `<a>` as a button), a **Query String**, an **Entity Context** (extra route params, e.g. a Group id), optional **Prefix/Suffix/Access-denied HTML**, a **destination** toggle, and **tokenize** (use replacement tokens from the first row — so buttons can carry values from contextual filters). Every option except Entity Type supports tokens. The actual add URL and access check come from a `@ViewsAddButton` plugin selected by the entity type: built-ins cover **node** (`node.add`), **taxonomy_term**, **user**, ECK entities, and a **Default** plugin that assumes `/{entity_type}/add/{bundle}` for anything else. You can override the render/access plugin per handler, or add your own `@ViewsAddButton` plugin for custom entities. The button only renders when the current user has create access to the chosen entity/bundle. No configuration page, permissions, or Drush — it is entirely per-view configuration. Requires Views and Token.

---

- Put an "Add article" button at the top of a content listing View.
- Add a create button that respects entity create-access (hidden if the user can't create).
- Render an add-user button on an administrative user list View.
- Add a "New term" button to a taxonomy overview View.
- Build a custom node list with an add button without nesting views or writing a handler.
- Use a contextual filter's value as a token in the button's query string or context.
- Pre-fill fields on the target add form via a query string (e.g. `field_x=value`).
- Style the add link as a themed button with `button`/`btn` CSS classes.
- Add multiple add buttons to one View, each for a different entity type/bundle.
- Include a destination parameter so the user returns to the View after creating.
- Show custom "access denied" HTML in place of the button when the user lacks create rights.
- Add prefix/suffix HTML around the button for layout.
- Create an add button for a Group-scoped entity by supplying the group id as Entity Context.
- Add a create button for an ECK entity type using the bundled ECK plugin.
- Provide a create button for a custom entity via the Default `/{type}/add/{bundle}` route assumption.
- Add a per-row add button as a Views field (e.g. add a related item).
- Tokenize the button using values from the first result row.
- Give editors a consistent "Add content" call-to-action across dashboard Views.
- Point the button at a specific bundle's add form by selecting the entity type + bundle.
- Override the URL-generation plugin for an entity with a non-standard add route.
- Override the access-check plugin to apply custom create-access logic.
- Write a custom `@ViewsAddButton` plugin to support an entity with a unique add route.
