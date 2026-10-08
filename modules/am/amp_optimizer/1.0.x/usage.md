<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AMP Optimizer transforms rendered HTML responses through the ampproject/amp-toolbox TransformationEngine so pages are served as server-side-optimized AMP.
---
The module wraps the PHP AMP Toolbox Optimizer and applies it as a `KernelEvents::RESPONSE` subscriber (`src/EventSubscriber/OptimizerSubscriber.php`, priority -9999). It only processes responses for anonymous users (it returns early when the current user is authenticated) and only for HTML responses, then hands the markup to the transformation engine and replaces the response content with the optimized output, logging any optimizer errors to the `amp_optimizer` channel.

Optimization tasks such as server-side rendering of AMP components and inlining/streamlining assets are handled by the underlying library; the Drupal layer wires it to the response pipeline and exposes a settings form at `/admin/config/services/amp/optimizer` (permission `administer site configuration`). Typical setup is installing the composer library dependency, enabling the module, ensuring the pages you serve are AMP, and confirming the optimizer runs for anonymous traffic.

There are no anonymous or mutating endpoints beyond the admin-gated settings form; the module reads the response body and rewrites it in place. Because it only runs for anonymous users, authenticated previews are unaffected.
---
- Serve server-side-rendered, optimized AMP pages to anonymous visitors.
- Apply AMP Toolbox transformations without writing PHP.
- Improve AMP validation and load performance automatically.
- Configure optimizer behavior at the settings form.
- Skip optimization for logged-in users by design.
- Limit processing to HTML responses only.
- Log optimizer errors to the amp_optimizer channel.
- Combine with an AMP theme/route setup.
- Reduce client-side AMP boilerplate via SSR.
- Inline/streamline critical assets through the toolbox.
- Gate configuration behind administer site configuration.
- Run late in the response pipeline (priority -9999).
- Integrate the ampproject/amp-toolbox library into Drupal.
- Troubleshoot AMP output using logged transformation errors.
- Keep authenticated editing/preview unoptimized.
- Toggle the optimizer by enabling/disabling the module.
- Optimize cached anonymous HTML responses.
- Provide AMP performance gains for SEO/mobile.
