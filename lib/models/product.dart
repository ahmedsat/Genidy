class Product {
  String pname;
  double pprice;
  double psale;
  String pdescription;
  String pcategory;
  String pimage;
  String pid;
  String pinfo;
  int pquantity;
  int pmaxQuantity;

  Product({
    this.pid = '',
    this.pname = ' no name',
    this.pprice = 0,
    this.psale = 0,
    this.pdescription = 'no description',
    this.pcategory = 'no category',
    this.pimage = 'https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132484366.jpg',
    this.pinfo = 'no info',
    this.pquantity = 1,
  });
  @override
  String toString() => pname;

  void show() {
    print('pid = > ${pid}');
    print('pname = > ${pname}');
    print('pprice = > ${pprice}');
    print('pdescription = > ${pdescription}');
    print('pcategory = > ${pcategory}');
    print('pimage = > ${pimage}');
    print('pinfo = > ${pinfo}');
    print('pquantity = > ${pquantity}');
  }
}
