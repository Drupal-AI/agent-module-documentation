# Plugin type — `ProjectBrowserSource` (add a custom project source)

A **source** supplies the catalog of projects the Browse page shows. Project Browser
defines this plugin type (all `@api`, covered by the BC promise):

- Attribute: `Drupal\project_browser\Attribute\ProjectBrowserSource`
- Interface: `Drupal\project_browser\Plugin\ProjectBrowserSourceInterface`
- Base class: `Drupal\project_browser\Plugin\ProjectBrowserSourceBase`
- Manager: `Drupal\project_browser\Plugin\ProjectBrowserSourceManager` (service; discovers
  `Plugin/ProjectBrowserSource/*`, alter hook `hook_project_browser_source_info_alter()`)

## Write a source

Put the class in `src/Plugin/ProjectBrowserSource/` of your module and extend the base.

```php
namespace Drupal\my_module\Plugin\ProjectBrowserSource;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\project_browser\Attribute\ProjectBrowserSource;
use Drupal\project_browser\Plugin\ProjectBrowserSourceBase;
use Drupal\project_browser\ProjectBrowser\ProjectsResultsPage;

#[ProjectBrowserSource(
  id: 'my_source',
  label: new TranslatableMarkup('My catalog'),
  description: new TranslatableMarkup('Projects from my registry.'),
  // Optional: expose the source as its own tab on the Browse page.
  local_task: [
    'title' => new TranslatableMarkup('My catalog'),
  ],
)]
final class MySource extends ProjectBrowserSourceBase {

  public function getProjects(array $query = []): ProjectsResultsPage {
    // $query keys: page, limit, sort, direction, search, categories,
    // maintenance_status, development_status, security_advisory_coverage,
    // machine_name.
    $projects = [/* Drupal\project_browser\ProjectBrowser\Project objects */];
    // Helper on the base class builds the results page:
    return $this->createResultsPage($projects, $total_results, $error);
  }

  public function getFilterDefinitions(): array {
    // Return Drupal\project_browser\ProjectBrowser\Filter\FilterBase[]
    // (TextFilter, BooleanFilter, MultipleChoiceFilter), keyed by machine name.
    return [];
  }

  // getSortOptions() is inherited (Most popular / A-Z / Z-A / Newest / Most relevant);
  // override to change it.
}
```

Interface contract:

| Method | Returns | Purpose |
|---|---|---|
| `getProjects(array $query)` | `ProjectsResultsPage` | Page of `Project` objects for the current query |
| `getFilterDefinitions()` | `FilterBase[]` | Filters the source honors, keyed by machine name |
| `getSortOptions()` | `string[]` | Sort id → human label |
| `getPluginDefinition()` | `array` | Plugin metadata |

Sources are `ConfigurableInterface`: per-source config comes from
`project_browser.admin_settings:enabled_sources.<id>` (add a matching
`project_browser.source.<id>` schema type if your source has settings). Enable the source
on the settings form to make it appear.

## Activators (install-side plugin type)

How a selected project is *installed* is a separate, tagged-service plugin type
(`@api` `Drupal\project_browser\Activator\ActivatorInterface`, tag
`project_browser.activator`). `ActivationManager` delegates to the first activator whose
`supports(Project)` is TRUE. Built-ins: `ModuleActivator` (enables/downloads modules via
Package Manager), `RecipeActivator` (applies recipes). Implement `getStatus()`,
`supports()`, and `activate()` to teach Project Browser to install a new kind of project.
