<?php
//
// disp_profs.inc.php
//

class ListItems extends RecursiveIteratorIterator {
  function __construct($it) {
    parent::__construct($it, self::LEAVES_ONLY);
  }
  function current() {
    return parent::current();
  }
  function beginChildren() {
    echo "<li> <button name='surveyID' type='submit' formaction='view_course_reviews.php'
          value='" . parent::current() . "' formmethod='POST'>" . parent::current() . "</button>\n";
  }
  function endChildren() {
    echo "</li>\n";
  }
}

// Connect to database server
include 'db_connect.php';

try {
  $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  $sql = "CALL sp_professors_for_a_course( :courseID );";

  $sth = $dbh->prepare($sql);
  $sth->bindParam(':courseID', $courseID);
  $sth->execute();

  echo "<ul>\n";

  // set the resulting array to associative
  $result = $sth->setFetchMode(PDO::FETCH_ASSOC);
  foreach(new ListItems(new RecursiveArrayIterator($sth->fetchAll())) as $k=>$v) {
    echo $v;
  }
  echo "</ul>";
  $dbh = null;
}
catch(PDOException $e) {
  $dbh = null;
  header("Location: error.php?err=" . $e->getMessage());
}