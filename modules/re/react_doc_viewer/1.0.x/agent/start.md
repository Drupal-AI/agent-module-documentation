<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# react doc viewer — agent orientation

Components:
- `RdvFieldFormatter` (file field formatter) → renders `#theme => rdv`, a link to `/rdv/{fid}`.
- `ReactDocViewerController::build()` → outputs `<div id="rdv-main__react">` and attaches the
  `react_doc_viewer` library (bundled React in `js/dist/index.js`).
- `ReactDocViewverRestResource` (`GET /react-doc-viewer/{fid}`) → loads the File entity and
  returns `{url, type}`.
- Route `/rdv/{fid}` gated by `_permission: 'access content'`; permission
  `access page file viewer` (restrict access: true).

Security review (no exploitable finding, but multiple defects):
- REST `get()` checks `hasPermission('access page file viewe')` — MIS-SPELLED (defined
  permission is `access page file viewer`), so the check passes for nobody (fails closed);
  it also throws `AccessDeniedHttpException` without importing the class (fatal). Additionally
  it does not call `$file->access('view')`, but is gated behind the REST `restful get`
  permission and the broken internal check.
- `getTitle()` calls `$this->getParameter()`/`$this->load()` which do not exist on
  `ControllerBase` → the title callback fatals. Bug, not a vuln.
- No SSRF: the endpoint returns the file's own URL by fid, never fetches a request-supplied URL.
