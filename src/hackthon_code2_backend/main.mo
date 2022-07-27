import Array "mo:base/Array";
import B "mo:base/Buffer";
import Blob "mo:base/Blob";
import Char "mo:base/Char";
import Debug "mo:base/Debug";
import I "mo:base/Iter";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import Nat8 "mo:base/Nat8";
import Option "mo:base/Option";
import Prim "mo:prim";
import Text "mo:base/Text";

actor HackathonDay2 {
  
  // Challenge 1

  public func nat_to_nat8(n: Nat): async Nat8 {
    // n qua lon de convert sang Nat8 ( Nat 8 max la 255);
    if(n > 255) {
      return 255;
    };

    return Nat8.fromNat(n);
  };

  // Challenge 2

  public func max_number_with_n_bits (n : Nat): async Nat {
      return 2**n -1;
  };

  // Challenge 3

  public func decimal_to_bits (n : Nat): async Text {
  var num = n;
  var bits = "";

  while(num > 0) {
    num := num/2;
    var digit = num % 2;
    if(digit == 1) {
      bits := "1" # bits;
    } else {
      bits := "0" # bits;
    };
  };

  return (bits);
  
 };

//  Challenge 4


  public func capitalize_character(char : Text) : async Text {
      var result = "";
        for(char in char.chars()) {
          let unicode_value = Char.toNat32(char);
          if(unicode_value >= 97 or unicode_value <= 122){
            result:= (Char.toText(Char.fromNat32(unicode_value - 32)));
          } else {
            result:= Char.toText(Char.fromNat32(unicode_value));
          };
        };

        return result;

};


// Challenge 5

// Method 1
  public func capitalize_text1 (c: Text) :async Text {
  var result = "";
  for(char in c.chars()) {
    if(Char.isLowercase(char)) {
      let num = Char.toNat32(char) - 32; 
      result := result # Char.toText(Char.fromNat32(num));
    } else {
      result := result # Char.toText(char);
    }
  };
  return result;
  };

  // Method 2
  public func capitalize_text2  (c : Text): async Text {

    let result = Text.map(c, Prim.charToUpper);

    return result;
  };

  // Challenge 6
  public func is_inside(t: Text, c : Text): async Bool {
        for(char in t.chars()) {
          if(char == c) return true;
        };
        return false;
        // return Text.contains(t,c);
  };
  // V2
  public func is_insideV2(t: Text, c : Text): async Bool {
       return Text.contains(t, #text c);
        // return Text.contains(t,c);
  };

  // Challenge 7
  public func trim_whitespace (t: Text): async Text {
    return Text.trim(t, #text " ");
  };

  // Challenge 8 --> finished
  public func duplicated_character (t: Text): async Text {
    let arrText = B.Buffer<Text>(3);
    // Chuyen no thanh mang
    for(char in t.chars()) {
      arrText.add(Char.toText(char));
    };

    let size = arrText.size();
    for(i in I.range(0,size - 2)) {
      if(arrText.get(i) == arrText.get(i + 1)) {
        return arrText.get(i);
      };
    };
      // var count : Nat = 0;
      return t;
  };

  // Challenge 9

  public func size_in_bytesV1 (t: Text): async Nat {
    var encodeText = Text.encodeUtf8(t);
    return encodeText.size();

  };

  public func size_in_bytesV2 (t : Text) : async Nat {
        let utf_blob = Text.encodeUtf8(t);
        let array_bytes = Blob.toArray(utf_blob);
        return(array_bytes.size()); 
  };

  // Challenge 10
  public func bubbleSort(array: [Nat]): async [Nat] {

    var array_mutable = Array.thaw<Nat> (array);

    let n = array.size();
    for(i in I.range(0,n-2)) {
      for(j in I.range(i + 1,n -1)) {
        if(array_mutable[i] > array_mutable[j]) {

          var temp = array_mutable[i];
          array_mutable[i] := array_mutable[j];
          array_mutable[j] := temp;
        
        }
      }
    };

    return Array.freeze(array_mutable);
  };    


  // Challenge 11

    public func nat_opt_to_nat(n: ?Nat, m: Nat): async Nat {
      switch(n) {
        case(null) {
          return m;
        };
        case(?num) {
          return num;
        };
      }
  };

  // Challenge 12

     public func day_of_the_week(n: Nat) : async ?Text {
      do ? {
      switch n {
        case (1) { "Monday" };
        case (2) { "Tuesday" };
        case (3) { "Wednesday" };
        case (4) { "Thursday" };
        case (5) { "Friday" };
        case (6) { "Saturday" };
        case (7) { "Sunday" };
        case (_) { null ! };
      };
    };
  };


  // Challenge 13
  let f13 = func (n : ?Nat) : Nat {

      switch(n) {
        case(null) {
          return 0;
        };
        case(?num) {
          return num;
        };

      }
  };
  public func populate_array(array: [?Nat]) :async [Nat] {
    
    return(Array.map<?Nat, Nat>(array, f13));
  } ;

  // Challenge 14

  public func sum_of_array (array: [Nat]) : async Nat {
   let sum =  Array.foldRight<Nat,Nat>(array,0, func (a,b) { return a + b;
    });
    return sum;
  };

  // Challenge 15
    let f15 = func (n : Nat) : Nat {
    return (n * n);
  };
  public func squared_array(array: [Nat]) : async [Nat] {
    return Array.map(array,f15);
  };

  // Challenge 16

  public func increase_by_index (array: [Nat]) : async [Nat] {

      return Array.mapEntries<Nat,Nat>(array, func (value, index) {
        return value + index;
      } );
  };

  // Challenge 17 --> Chưa hiểu ?

  // public func contains<A> (array: [A], typeOfA : A, f17: Bool): async Bool {
  //     return 
  // }

   private func contains<A>(arr: [A], a: A, f: (A, A) -> Bool): async Bool {
      Option.isSome(Array.find<A>(arr, func(x) { f(x, a) }))
    };

};
