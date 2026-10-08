<?php
// Identify which hook throws "cannot have a URI as it does not have an ID" on new node save.
use Drupal\node\Entity\Node;
$b = array_key_first(\Drupal::entityTypeManager()->getStorage('node_type')->loadMultiple());
try {
  $n = Node::create(['type' => $b, 'title' => 'zz_diag_probe']);
  $n->save();
  echo "NODE SAVE OK (id " . $n->id() . ")\n";
  $n->delete();
} catch (\Throwable $e) {
  // unwrap to the original exception (the wrapping EntityStorageException hides the hook)
  $orig = $e;
  while ($orig->getPrevious()) { $orig = $orig->getPrevious(); }
  echo 'ORIG CLASS: ' . get_class($orig) . "\n";
  echo 'ORIG MSG: ' . $orig->getMessage() . "\n";
  foreach ($orig->getTrace() as $i => $f) {
    $file = $f['file'] ?? '';
    // only show contrib/custom module frames + hook invocations
    if (strpos($file, '/modules/') === false && strpos(($f['function'] ?? ''), 'hook') === false && strpos(($f['function'] ?? ''), 'invoke') === false) continue;
    $fn = ($f['class'] ?? '') . ($f['type'] ?? '') . ($f['function'] ?? '');
    $loc = basename($file ?: '?') . ':' . ($f['line'] ?? '?');
    echo "  #$i $fn @ $loc\n";
    if ($i > 25) break;
  }
}
