// Gmsh project created on Wed Dec 01 21:48:31 2021
SetFactory("OpenCASCADE");
//+
Rectangle(1) = {0, 0, 0, 0.02, 0.02, 0};
//+
Rectangle(2) = {0, 0, 0.005, 0.02, 0.02, 0};
//+
Rectangle(3) = {0, 0, 0.007, 0.02, 0.02, 0};
//+
Line(13) = {9, 5};
//+
Line(14) = {5, 1};
//+
Line(15) = {2, 6};
//+
Line(16) = {6, 10};
//+
Line(17) = {11, 7};
//+
Line(18) = {7, 3};
//+
Line(19) = {4, 8};
//+
Line(20) = {8, 12};
//+
Curve Loop(4) = {9, -16, -5, -13};
//+
Plane Surface(4) = {4};
//+
Curve Loop(5) = {1, 15, -5, 14};
//+
Plane Surface(5) = {5};
//+
Curve Loop(6) = {12, 13, -8, 20};
//+
Plane Surface(6) = {6};
//+
Curve Loop(7) = {19, 8, 14, -4};
//+
Plane Surface(7) = {7};
//+
Curve Loop(8) = {10, 17, -6, 16};
//+
Plane Surface(8) = {8};
//+
Curve Loop(9) = {18, -2, 15, 6};
//+
Plane Surface(9) = {9};
//+
Curve Loop(10) = {11, -20, -7, -17};
//+
Plane Surface(10) = {10};
//+
Curve Loop(11) = {19, -7, 18, 3};
//+
Plane Surface(11) = {11};
//+
Surface Loop(1) = {7, 11, 9, 1, 5, 2};
//+
Volume(1) = {1};
//+
Surface Loop(2) = {6, 4, 8, 10, 3, 2};
//+
Volume(2) = {2};//+
Show "*";
//+
Hide "*";
//+
Show {
  Point{5}; Point{6}; Point{9}; Point{10}; Curve{5}; Curve{9}; Curve{13}; Curve{16}; Surface{4}; 
}
//+
Show "*";
