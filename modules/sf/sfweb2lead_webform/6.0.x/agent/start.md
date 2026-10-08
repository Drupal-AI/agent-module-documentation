# sfweb2lead_webform — agent start

Adds one **Webform handler**, `sfweb2lead_post` ("Salesforce Web-to-Lead post", class
`SalesforceWebToLeadPostWebformHandler` extends core Webform `RemotePostWebformHandler`),
that POSTs completed webform submissions to a Salesforce **Web-to-Lead** URL, mapping webform
elements to standard Salesforce lead fields. Requires `webform`. No config schema /
permissions / Drush of its own — configured per webform on its handler. Web-to-Lead auth is
just the public **OID** (no API key/secret stored).

- Add + configure the handler (URL, OID, field mapping, custom data, debug) → [configure/sfweb2lead_webform.md](configure/sfweb2lead_webform.md)
- Alter the outgoing payload via the `sfweb2lead_webform.submit` event → [api/sfweb2lead_webform.md](api/sfweb2lead_webform.md)
