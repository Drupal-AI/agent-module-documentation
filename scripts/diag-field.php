<?php
// Capture the exact current blocker for field-storage creation.
use Drupal\field\Entity\FieldStorageConfig;
try {
  $fs = FieldStorageConfig::create(['field_name' => 'field_diag_probe', 'entity_type' => 'node', 'type' => 'string']);
  $fs->save();
  echo "FIELD CREATE OK\n";
  $fs->delete();
  echo "cleanup OK\n";
} catch (\Throwable $e) {
  echo 'BLOCKER: ' . get_class($e) . "\n";
  echo 'MSG: ' . $e->getMessage() . "\n";
  $t = $e->getTrace();
  foreach (array_slice($t, 0, 6) as $i => $f) {
    echo "  #$i " . ($f['class'] ?? '') . ($f['type'] ?? '') . ($f['function'] ?? '') . ' @ ' . basename($f['file'] ?? '?') . ':' . ($f['line'] ?? '?') . "\n";
  }
}
