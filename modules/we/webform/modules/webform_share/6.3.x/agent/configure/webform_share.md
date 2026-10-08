# Configure sharing / embedding

No global settings form — enable the module, then use each webform's **Share** tab. Sharing
per webform is controlled by the webform's own settings/access.

## Admin (get embed code)
`/admin/structure/webform/manage/{webform}/share` (route `entity.webform.share_embed`) →
copy the iframe or JavaScript snippet. Preview: `…/share/preview`; test: `…/share/test`.
Node variants exist too (`/node/{node}/webform/share`).

## Public embed endpoints
| Route | Path | Serves |
|---|---|---|
| `entity.webform.share_page` | `/webform/{webform}/share` | Standalone (chrome-free) form page for an iframe |
| `entity.webform.share_script` | `/webform/{webform}/share.js` | JS that injects the form iframe into a host page |
| `entity.webform.share_page.javascript` | `/webform/{webform}/share/{library}/{version}` | Versioned share JS library |

## How isolation works (src)
- `Theme/WebformShareThemeNegotiator` + `EventSubscriber/WebformShareDisplayVariantSubscriber`
  strip the site theme so the shared render is bare.
- `Routing/WebformShareRouteSubscriber` attaches share routes to webforms and webform nodes.
- `Element/WebformShareIframe` and `Element/WebformShareScript` build the embed markup;
  `WebformShareHelper` produces the copyable code.
