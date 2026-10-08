# webform_example_remote_post — agent start

Developer example module. Provides a local mock REST endpoint + demo webform to exercise Webform's core Remote Post handler. Depends on `webform` + `token`. No config UI, permissions, or schema.

Key source (read directly — shorter than any summary):
- `webform_example_remote_post.routing.yml` — route `/webform_example_remote_post/{type}` (open access).
- `src/Controller/WebformExampleRemotePostController.php` — mock endpoint returning JSON; `{type}` simulates insert/update/delete.
- `config/install/webform.webform.example_remote_post.yml` — demo webform pre-wired to post here.
