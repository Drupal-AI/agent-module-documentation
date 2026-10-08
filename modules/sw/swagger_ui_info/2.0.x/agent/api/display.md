<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `/swagger_info` display page & spec loading

Source: `src/Controller/SwaggerUiInfoController.php`, route `swagger_ui_info.swagger_info` at
**`/swagger_info`** (title "API info"), permission **`access swagger ui information`**
(`restrict access: TRUE`, `swagger_ui_info.permissions.yml`). Not open to anonymous by default.

![Swagger UI info display page](../../../../../../../screenshots/swagger_ui_info/2.0.x/display-page.png)

## `SwaggerUiInfoController::infoPage()` flow

1. Generates a REST CSRF token: `$token = $this->csrfToken->get('rest')`.
2. Checks the Swagger UI library is registered:
   `libraryDiscovery->getLibraryByName('swagger_ui_formatter', 'swagger_ui_formatter.swagger_ui_integration')`.
   If missing/unsupported it returns a `status_messages` render array with the error
   "The Swagger UI library is missing, incorrectly defined or not supported."
3. Resolves the library directory via the injected
   `swagger_ui_formatter.swagger_ui_library_discovery` service (`getLibraryDirectory()`, which
   calls its `libraryDirectory()` method) and builds
   `$oauth2_redirect_url = request->getSchemeAndHttpHost() . '/' . $library_dir . '/dist/oauth2-redirect.html'`.
4. Reads the spec location from **State**: `$swagger_file_url = $this->state->get('swagger_ui_file_path')`.
   If NULL, returns the error "Could not create URL to file." (i.e. nothing configured yet).
5. Otherwise returns a `#theme => 'swagger_ui_info'` render array (name `api-display`) that
   attaches libraries `swagger_ui_formatter/swagger_ui_formatter.swagger_ui_integration` and
   `swagger_ui_info/swagger_ui_integration`, and passes `drupalSettings.swaggerUIFormatter['api-display']`:
   `csrfToken` (the `rest` token), `oauth2RedirectUrl`, `swaggerFile` (the State URL/path),
   `docExpansion => 'list'`, and `supportedSubmitMethods` (get/put/post/delete/options/head/patch).

## How the spec reaches Swagger UI (client-side)

The theme hook `swagger_ui_info` (`templates/swagger-ui-info.html.twig`) renders
`<div id="swagger-ui-api-display"></div>`. The module's JS
(`accets/js/swagger-ui-formatter.js`, `Drupal.behaviors.swaggerUIFormatter`) iterates
`drupalSettings.swaggerUIFormatter` and calls `SwaggerUIBundle({ url: swaggerFile, dom_id: '#swagger-ui-api-display', … })`.
The **browser** fetches the `swaggerFile` URL — the server does not fetch the spec. A
`requestInterceptor` adds `X-CSRF-Token: <csrfToken>` to each "Try it out" request so live
calls against the site's REST API pass Drupal's CSRF check. `validatorUrl` ends up `undefined`
(the controller sets no `validator` key), so Swagger UI uses its default badge validator.

## Notes

- The spec is a single site-wide value; there is no per-request `?url=` parameter — the page
  always renders whatever State `swagger_ui_file_path` holds.
- The bundled Swagger UI library version is whatever `swagger_ui_formatter` installs (this site:
  `swagger_ui_formatter` 4.4.x); manage/upgrade the library there, not here.
- The controller injects `csrf_token`, `library.discovery`,
  `swagger_ui_formatter.swagger_ui_library_discovery`, `request_stack`, and `state`.
