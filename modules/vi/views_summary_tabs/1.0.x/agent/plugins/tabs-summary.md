# `tabs_summary` — Views summary style plugin

The module's entire surface: one Views **style** plugin that renders an argument **summary** as tabs.
There is nothing else — no routes, services, forms, permissions, or drush.

- Id: **`tabs_summary`**. Class: `Drupal\views_summary_tabs\Plugin\views\style\TabsSummary`
  (`src/Plugin/views/style/TabsSummary.php`), extends
  `Drupal\views\Plugin\views\style\DefaultSummary`.
- Annotation: `@ViewsStyle(id = "tabs_summary", title = @Translation("Tabs"),
  help = @Translation("Displays the summary as a set of tabs."),
  theme = "views_view_summary_tabs", display_types = {"summary"})`.
- `display_types = {"summary"}` means it is offered **only** as a *summary* format — the presentation
  used when a contextual filter has no value — never as the main row style of a display.

## Where it shows up in the Views UI

1. Add a **contextual filter** (argument) to a display.
2. Under **"When the filter value is NOT available"**, choose **"Display a summary"**.
3. The **Summary settings** now expose a **format**; pick **Tabs**. `tabs_summary` is that format.
4. In the Tabs format settings, set **Classes** (the `classes` option) and the inherited
   **Display record count with link** option.

## Options

`defineOptions()` (`TabsSummary.php:26`) adds exactly one option on top of `DefaultSummary`'s:

| Option | Type | Default | Meaning |
|---|---|---|---|
| `classes` | string | `tabs tabs--primary` | CSS classes placed on the wrapping `<ul>`. |

`buildOptionsForm()` (`TabsSummary.php:35`) calls the parent form first (which provides the standard
summary options — base path, whether to show the count, override, items to display, etc.) then adds a
**Classes** textfield bound to `$this->options['classes']`. Every other summary option is inherited
unchanged from `DefaultSummary`.

Config schema (`config/schema/views_summary_tabs.views.schema.yml`):

```yaml
views.style.tabs_summary:
  type: views.style.default_summary
  label: 'Tabs'
  mapping:
    classes:
      type: string
      label: 'Classes'
```

Because it inherits `views.style.default_summary`, a saved display stores
`style: { type: tabs_summary, options: { classes: '…', count: true, … } }`.

## Rendering: theme hook, preprocess, template

- Theme hook **`views_view_summary_tabs`** is declared in `views_summary_tabs_theme()`
  (`views_summary_tabs.module`) with variables `view`, `options`, `rows`, pointing at the file
  `views_summary_tabs.theme.inc`.
- Preprocess **`template_preprocess_views_view_summary_tabs(&$variables)`**
  (`views_summary_tabs.theme.inc:11`):
  - calls core's `template_preprocess_views_view_summary($variables)` — this builds `rows` exactly as
    the default summary does (each row exposes `url`, `link`, `count`, `attributes`, `active`);
  - if the active theme is **`olivero`**, appends `olivero/tabs` to
    `$variables['#attached']['library']`;
  - if **no** row is already `active`, forces the **first** row active (`$rows[0]->active = TRUE`).
    Two `@todo`s in the code note that reading the parent default value and making the active-tab
    behaviour configurable are not implemented — so active-tab detection is deliberately basic
    (first row unless Views core already flagged one).
- Template **`templates/views-view-summary-tabs.html.twig`** emits:

```twig
<nav role="navigation" class="tabs-wrapper" aria-labelledby="primary-tabs-title" data-drupal-nav-primary-tabs>
  <ul class="{{ options.classes }}">
    {% for row in rows %}
      <li class="tabs__tab"><a href="{{ row.url }}"{{ row.attributes.addClass(row.active ? 'is-active')|without('href').addClass('tabs__link') }}>{{ row.link }}</a>
        {% if options.count %}
          ({{ row.count }})
        {% endif %}
      </li>
    {% endfor %}
  </ul>
</nav>
```

Template variables: `rows` (each with `url`, `link`, `count`, `attributes`, `active`) and `options`
(`count` flag, `classes` string). The active row's link gets the `is-active` class; every link gets
`tabs__link`; each `<li>` gets `tabs__tab`; `options.classes` goes on the `<ul>`. `options.classes`
is HTML-escaped by Twig autoescaping.

## Styling

The default `tabs tabs--primary` / `tabs__tab` / `tabs__link` / `is-active` class names mirror core's
**primary local-tasks** markup, so in most admin themes and in Olivero the summary immediately looks
like primary tabs. Change the `classes` option to retarget it to another design system's classes.
Under Olivero the `olivero/tabs` library is auto-attached; other themes rely on their own tab CSS or
the classes you provide. To change the markup itself, override
`views-view-summary-tabs.html.twig` in your theme.

## Extending / notes

- This is a plugin *instance*, not a plugin *type* — there is nothing to subclass or register, and
  `provides_plugin_types` is empty. You interact with it purely through the Views UI or a view's
  config export.
- Everything the default summary supports (count display, summary sorting, items per page) is
  inherited from `DefaultSummary`; only the presentation (tabs markup + the `classes` option)
  differs.
