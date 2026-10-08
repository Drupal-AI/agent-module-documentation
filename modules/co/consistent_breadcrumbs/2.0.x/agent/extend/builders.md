<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Adding a breadcrumb builder

Consistent Breadcrumbs assembles the trail from tagged plugins collected by `ConsistentBreadcrumbManager`.

To add one, define a service tagged `consistent_breadcrumb_builder` with a `priority` and implement `Drupal\consistent_breadcrumbs\ConsistentBreadcrumbBuilderInterface`:

```yaml
services:
  my_module.breadcrumb.custom:
    class: Drupal\my_module\CustomBreadcrumbBuilder
    tags:
      - { name: consistent_breadcrumb_builder, priority: 100 }
```

The manager sorts builders by priority (higher first) and the first applicable builder wins; the bundled `path_based` (-900) and `trivial` (-1000) builders act as low-priority fallbacks. Return `BreadcrumbItem` objects; the `ConsistentBreadcrumbsRoutingHelper` resolves route titles for path segments and the access manager filters out links the current user cannot reach. Results are cached in the `consistent_breadcrumbs` memory cache bin, so include appropriate cache metadata.
