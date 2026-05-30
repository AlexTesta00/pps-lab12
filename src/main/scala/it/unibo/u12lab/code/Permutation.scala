package it.unibo.u12lab.code

object Permutation:

  /*
   * lookup(List(10,20,30)) produces a LazyList of pairs (element, rest of the list without that element).:
   *
   * (10, List(20,30))
   * (20, List(10,30))
   * (30, List(10,20))
   *
   */
  def lookup[A](list: List[A]): LazyList[(A, List[A])] =
    list match
      case Nil =>
        LazyList.empty

      case h :: t =>
        (h, t) #::
          lookup(t).map {
            case (e, rest) => (e, h :: rest)
          }

  /*
   * Generate all permutations of a list.
   */
  def permutations[A](list: List[A]): LazyList[List[A]] =
    list match
      case Nil =>
        LazyList(Nil)

      case _ =>
        for
          (h, rest) <- lookup(list) /* choose one element h of the list*/
          permRest <- permutations(rest) /* generate all permutations of the remaining elements */
        yield h :: permRest /* prepend the chosen element to each of the generated permutations */


@main def testPermutation(): Unit =
  println("Permutation of List(1,2,3):")

  Permutation
    .permutations(List(1, 2, 3))
    .foreach(println)

  println()
  println("first 100 permutations of List(1,...,20):")

  Permutation
    .permutations((1 to 20).toList)
    .take(100)
    .foreach(println)