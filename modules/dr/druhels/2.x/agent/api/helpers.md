<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# druhels helper classes — API map

All classes live in `src/<Class>.php`, namespace `Drupal\druhels`, and expose **`public static`** methods only (no services, no DI). Call `use Drupal\druhels\<Class>;` then `<Class>::method(...)`. Signatures below are abbreviated; check the source for exact defaults. Helpers depending on an optional module fatal if that module is absent.

## DrupalHelper — runtime / page context (`DrupalHelper.php`)
- `getCurrentPageTitle($request=NULL)` / `setCurrentPageTitle($title, $unset_route_title_callback=FALSE, $route_match=NULL)` — read/override the resolved page title.
- `getCurrentRouteName()`, `getCurrentSystemPath()`, `getCurrentPathAlias()` — current route/path (statically cached per request).
- `isAdminRoute()`, `isFrontPage()`, `isViewsPage($views_name, $display_name=NULL)` — page predicates.
- `getDefaultLangcode()`, `getCurrentLangcode()`, `getSiteMail()`.
- `sendMail($to, $subject, $message, $key='druhels', $langcode=NULL, $params=[])` — sends via `plugin.manager.mail` using the module's own `hook_mail()`; no custom `hook_mail()` needed.
- `render($build)` — render a render-array/string via the `renderer` service.
- `removeStatusMessage($type, callable $callback)` — delete matching messenger messages.
- `timerStart($name='druhels')` / `timerStop($name='druhels', $show_result=TRUE)` — wrap core `Timer` + memory delta, printed to messenger. Global aliases `timer_start()` / `timer_stop()` in `druhels.module`.
- `getBreakpointMediaQuery($group, $breakpoint_name)`.

## EntityHelper — generic entity/field access (`EntityHelper.php`)
- `view($entity, $view_mode='full')` / `viewWithFields(...)` — render-array via the entity's view builder (`viewWithFields` runs `#pre_render`).
- `getCurrentEntity($route_match=NULL)`, `isEntityPage($entity_type_id=NULL)` — detect/load the entity on an `entity.*.canonical` route.
- Field reads: `getFieldLabel(...)`, `getListFieldAllowedValues(...)`, `getListFieldValueLabel($item)`, `getFieldValues($items, $prop=NULL)`, `getExistsFieldValue($entity, $field, $prop='value')`, `getReferencedEntities($items)` (keyed by entity id), `getReferencedEntitiesFieldValues(...)`.
- Field metadata: `bundleHasField(...)`, `getBundleFieldDefinitionsByType(...)`, `fieldHasValue(...)`, `referencedEntitiesFieldHasValue(...)`, `fieldHasAffectingChanges($entity, $field)`.
- Misc: `deleteMultiple($ids, $entity_type_id)`, `getContentEntityTypes()`, `getTranslatedEntity($entity, $langcode=NULL)`, `setThirdPartySettings(...)`, `getEntityDataTableName(...)`, `getFieldDataTableName(...)`, `getImageFieldDefaultImageInfo(...)`, `getImageFieldDefaultImageEntity(...)`.

## NodeHelper — node context (`NodeHelper.php`, needs `node`)
- `isNodePage($node_type=NULL)`, `getCurrentNodeId(...)`, `getCurrentNode(...)`.
- `view($node|$nid, $view_mode='full')`, `viewMultiple($nodes, ...)`, `getNodeStorage()`, `getNodeUrl($nid, $options=[])`.

## TaxonomyHelper — taxonomy hierarchy (`TaxonomyHelper.php`, needs `taxonomy`)
Largest class; tree/parent/child walking on top of `TermStorage::loadTree()`/`loadAllParents()`.
- Lookup/create: `getTermIdByName(...)`, `getTermByName(...)`, `getTermIdByProperties($props)`, `createTerm(...)`, `createTerms(...)`, `getTermsByNamesHierarchy(...)`, `createTermsByNamesHierarchy(...)`.
- Children: `getTermsByVocabulary(...)`, `getAllChildTerms(...)`, `getAllChildTermsIds(...)`, `getDirectChildTerms(...)`, `getDirectChildTermsIds(...)`, `termHasChilds(...)`.
- Parents/depth: `getTermDepth($term)`, `getTermParent(...)`, `getTermParentId(...)`, `getAllParentsTerms(...)`, `getAllParentsTermsRaw(...)`, `getAllParentsTermsIds(...)`, `getAllParentsTermsNameRaw(...)`, `getDirectParentsIds(...)`, `getRootParentTerm(...)`, `getRootParentTermId(...)`, `termHasDirectParent(...)`.
- Page/util: `isTermPage(...)`, `getCurrentTermId(...)`, `getCurrentTerm(...)`, `getTermUrl($tid, $options=[])`, `getTermStorage()`, `getTermsName($ids, $use_term_load=TRUE)` (optional direct `taxonomy_term_field_data` SELECT with an IN condition), `formatTermsAsTree($terms)`.

## CommerceHelper — Commerce cart/order/product (`CommerceHelper.php`, needs `commerce`, `commerce_order`, `commerce_price`, `commerce_product`, `commerce_cart`, `commerce_store`)
- Carts: `getCart(...)`, `getCarts($account=NULL, $only_filled=FALSE)`, `getCartsTotalPrice(...)`, `clearCarts(...)`, `getCartsTotalQuantity()`, `getCartsItemsCount()`, `addToCart($purchasable_entity, $quantity)`.
- Variations: `orderHasVariation(...)`, `cartsHasVariation(...)`, `getOrderItemsByVariationId(...)`, `getCartsItemsByVariationId(...)`, `getCartItemQuantityByVariationId(...)`, `getOrderTotalQuantity($order)`.
- Product page: `isProductPage(...)`, `getCurrentProductId(...)`, `getCurrentProduct(...)`, `productView($product, $view_mode='full')`.
- Price: `getDefaultCurrencyCode()`, `formatPrice($price, $options=[])` (via `commerce_price.currency_formatter`).

## UserHelper — roles / admin (`UserHelper.php`, needs `user`)
- `currentUserHasRole($role)`, `currentUserIsAdmin()` (checks the `administrator` role), `getAdminRole()` (the `is_admin` role), `getAdminUser()`.

## ParagraphHelper (`ParagraphHelper.php`, needs `paragraphs`)
- `getRootEntity(ParagraphInterface $paragraph)` — climb parents to the non-paragraph root entity.

## FileHelper (`FileHelper.php`, needs `file`; image-style method needs `image`)
- `getFileEntityByUri($uri)`, `createFileEntityByUri($uri, $values=[], $save=TRUE)`, `getFileExtension($filename)`, `getImageStyleUrl($image_path, $style_name, $absolute_url=FALSE)`, `getFileStorage()`.

## BlockHelper (`BlockHelper.php`, needs `block`, `block_content`, and the `improvements` module — imports `ImprovementsBlockViewBuilder`)
- `viewByBlockPluginId($id, $wrapper=TRUE, $label='', $add_cacheable_metadata=TRUE, &$block_plugin=NULL)` — instantiates the block plugin, checks `access()` for the current user, returns render array (no render cache).
- `viewByBlockPluginIdUsingNativeBuilder(...)`, `viewByBlockConfigId($config_id)`, `viewByContenBlockId($content_block_id, ...)`.

## SeoHelper — head/markup attachments (`SeoHelper.php`)
- `attachHtmlHead(&$build, $name, $tag, $attributes)`, `attachMetatag(&$build, $name, $meta_name, $content)`, `attachMetatagNoindex(&$build)`, `attachCanonical(&$build, $url)`, `attachJsonld(&$build, $name, $array, $weight=1000)` — push into `$build['#attached']['html_head']`.
- `renderSchemaorgData($data)` — returns a schema.org microdata **string**; caller places it into markup. Attribute values and meta content are passed through `Html::escape()`.

## ArrayHelper — array utilities (`ArrayHelper.php`)
Key/order: `renameKeysToColumnValue`, `insert`/`insertBefore`/`insertAfter`/`insertAfterValue`, `moveBefore`, `renameKey`, `sortBySecondArrayValues`/`sortBySecondArrayKeys`, `getFirstKey`/`getLastKey`, `getValueByIndex`.
Filter/remove: `removeEmptyElements($a, $recursive=FALSE)`, `removeElementByKey`, `removeElementsByKeys`, `removeExtraElements`, `removeElementFromNestedArray($a, $keys, $clear_branch=FALSE)`.
Search/test: `searchAndReplace`, `searchInTwodimArray`, `keysExists`, `columnIsEmpty`, `arrayContainsAtLeastOneValueFromOtherArray`, `randomSlice`.
Format/convert: `getTextLines`, `implodeMultiArray`, `formatArrayAsKeyValueList`/`formatKeyValueListAsArray`, `formatArrayAsAttributes`, `csvToArray($uri, $sep=';', $header=TRUE)` (Generator; opens `$uri` with `fopen`).

## StringHelper (`StringHelper.php`)
- `removeDoubleSpaces`, `stripTags` (decode entities + `strip_tags` + collapse whitespace), `pregMatch($pattern, $text, $index=NULL)`, `convertToFloat` (comma decimal → float), `removeHtmlComments`.

## DateHelper (`DateHelper.php`)
- `createPhpDateTime($date)` (string|int|DrupalDateTime|DateTime → `\DateTime`), `getDateTimestamp($date)`, `getDaysBetweenDates(...)`, `checkDateInDaterange(...)`, `dateIsGreaterThan(...)`, `getDateSeason($date)` (0–4), `getDateSeasonStart($date)`.

## FormHelper (`FormHelper.php`)
- `cleanGetForm(array $form)` — strip `form_id`/`form_build_id`/`form_token` from a GET form.
- `moveLabelsToPlaceholder(array &$form, $mark_required_fields=TRUE)` — recursively copy `#title` into `#placeholder` for text-like elements.

## CommonHelper (`CommonHelper.php`)
Empty placeholder class (no methods).
