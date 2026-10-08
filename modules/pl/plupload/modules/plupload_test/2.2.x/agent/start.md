# Plupload test — agent index

Demo/support submodule of **plupload**. Provides one example form showing how to use the
`plupload` element and process its uploaded files. No config, no permissions, no services,
no plugins.

- **The demo form: route, form id, and the submit-handler pattern it demonstrates** →
  [api/demo-form.md](api/demo-form.md)

Key facts:
- Route `plupload.test` → path `/plupload-test`, `_access: 'TRUE'` ("Do not enable in
  production").
- Form class `\Drupal\plupload_test\PluploadTestForm`, form id `_plupload_test_form`.
- Renders a `#type => 'plupload'` element limited to `zip`; validates `status === 'done'`;
  moves finished temp files into `<default_scheme>://plupload-test` without creating File
  entities.
- For the element itself see the parent module:
  `modules/plupload/2.2.x/agent/api/element.md`.
