<?php
//
// disp_profs.inc.php
//

class ListItems2 extends RecursiveIteratorIterator {
  function __construct($it) {
    parent::__construct($it, self::LEAVES_ONLY);
  }
  function current() {
    return parent::current();
  }
  function beginChildren() {
    echo "<li> <button name='courseID' type='submit' formaction='view_course_reviews.php'
    value='" . parent::current() . "' formmethod='POST'>";
  }
  function endChildren() {
    echo "</button></li>\n";
  }
}


// Connect to database server
include 'db_connect.php';

try {
  $professorID = $_POST['professorID'];

  $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  $sql = "SELECT DISTINCT courseID, courseName
          FROM Section NATURAL JOIN Course
	        WHERE professorID = :professorID;";


  $sth = $dbh->prepare($sql);
  $sth->bindParam(':professorID', $professorID);
  $sth->execute();
  $result = $sth->setFetchMode(PDO::FETCH_ASSOC);

  // if(count($result) > 1)
  // // {
  // //echo"<h3>Other Courses Taught By This Professor</h3>";
  echo "<ul>\n";
  //
  // set the resulting array to associative
  foreach(new ListItems2(new RecursiveArrayIterator($sth->fetchAll())) as $k=>$v) {
    echo $v . " ";
  }
  echo "</ul>\n";
  $dbh = null;
}
catch(PDOException $e) {
  $dbh = null;
  header("Location: error.php?err=" . $e->getMessage());
}
