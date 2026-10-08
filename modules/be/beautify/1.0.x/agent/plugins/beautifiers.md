<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Beautify — beautifier plugins

Plugin type `Beautifier` (annotation `Drupal\beautify\Annotation\Beautifier`), manager
`Drupal\beautify\BeautifierManager`, base `Plugin/Beautifier/BeautifierPluginBase`.

Bundled plugins:
- **HtmlBeautify** (`Plugin/Beautifier/HtmlBeautify.php`) — pure-PHP indentation/formatting.
- **Tidy** (`Plugin/Beautifier/Tidy.php`) — uses the PHP `tidy` extension; requires it to be installed.

Selection and options are edited on `beautify.settings_form`
(`/admin/config/development/beautifier`, permission `admninister beautifiers`) through
`PluginForm/BeautifierPluginForm`. The active plugin runs inside the
`BeautifyResponseFilter` response subscriber against the rendered HTML.

Add a custom beautifier by implementing `BeautifierPluginInterface` and annotating it with
`@Beautifier`.
