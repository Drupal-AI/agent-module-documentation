# Configuration

Template Suggester has no admin settings form. You configure it in three parts:
declare your custom suggestions in a YAML file in your theme, add the field to an
entity, then create the Twig templates the suggestions point to.

## 1. Declare your suggestions in the theme

Create a file named `template_suggester.yml` in your active theme's folder and list
the suggestions you want to offer. The structure is entity → suggestion key →
details, with an optional list of bundles the suggestion applies to. For example:

```yaml
node:
  style_1:
    name: 'Visible name'
    bundles:
      - article
```

Here `node` is the entity, `style_1` is the machine key for the suggestion, `name`
is the label editors will see, and the suggestion is offered on the `article`
bundle.

## 2. Add the Template Suggester field

Add a field of type **Template Suggester** to the entity (for example on a content
type's **Manage fields** screen). When editing content, the field lets the editor
select one of the suggestions you declared for that entity/bundle.

## 3. Create the matching templates

Selecting a suggestion makes Drupal look for extra template suggestions built from
the entity, the current bundle, the selected suggestion, and the view mode. Using
the `style_1` example on a node, the templates it will look for include:

```
node--style-1.html.twig
node--article--style-1.html.twig
node--style-1--full.html.twig
node--article--style-1--full.html.twig
```

(The dashes come from Drupal's usual conversion of underscores in template
filenames.) Create whichever of these templates you need in your theme and put your
custom markup in them. Once a suggestion has its own template, you can customise
that display however you like.

## 4. Clear the cache

After adding the YAML file and templates, clear Drupal's cache (for example
`drush cr`) so the new suggestions and template files are picked up. Then edit a
piece of content, choose a suggestion, and view it to confirm the right template is
used.

## Tested entities

The module is documented as tested and working with **nodes**, **taxonomy terms**,
and **paragraphs**.
