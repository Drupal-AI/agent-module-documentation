<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing stories in Twig (`{% stories %}` / `{% story %}`)

The module registers a Twig extension (from `e0ipso/twig-storybook`,
`TwigStorybook\Twig\TwigExtension`) adding two tags. Put them in a file named
`<name>.stories.twig` (the Drush scanner only matches `*.stories.twig`).

## The two tags

- `{% stories <id> with { title: 'Group/Path' } %}` … `{% endstories %}` — declares a story
  group. `title` is the Storybook sidebar path (e.g. `Components/Examples/Card`).
- `{% story <id> with { name: '…', args: { … } } %}` … `{% endstory %}` — one story
  variant. `name` is its label; `args` become variables available to the Twig inside the block
  (and are recorded in the compiled JSON so Storybook controls can drive them).

## Example (`my-card.stories.twig`)

```twig
{% stories my_card with { title: 'Components/Examples/Card' } %}

  {% story default with {
    name: '1. Default',
    args: { header: 'I am a header!', text: 'Learn more', iconType: 'power' }
  } %}
    {# args above are exposed as variables here 👇 #}
    {% embed '@examples/my-card' with { header } %}
      {% block card_body %}
        <p>I am the <em>card</em> contents.</p>
        {% include '@examples/my-button' with { text, iconType } %}
      {% endblock %}
    {% endstory %}

{% endstories %}
```

Each `{% story %}` renders arbitrary Twig — typically `embed`/`include` of the real
component template — so Storybook shows genuine Drupal markup.

## From Twig to Storybook

1. Author `*.stories.twig` next to your components (in a module or theme).
2. Compile to `*.stories.json`: `drush storybook:generate-all-stories` (run from the docroot —
   see [../drush/commands.md](../drush/commands.md)).
3. The Storybook app loads the JSON; for each story it calls
   `/storybook/stories/render/{hash}` on Drupal, which returns the Twig-rendered HTML (theme
   negotiated, absolute asset URLs). The render route needs the `render storybook stories`
   permission — see [../configure/setup.md](../configure/setup.md).

## Notes

- `attach-behaviors.js` (`storybook/attach_behaviors` library) re-runs Drupal JS behaviors on
  the rendered story so behavior-driven components work in the iframe.
- There is no theme hook to override here; the module renders your own templates. Story files
  are source you write, not templates the module ships.
