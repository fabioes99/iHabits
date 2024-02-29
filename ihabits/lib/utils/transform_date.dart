List<int> transformDate(List<bool> selectedDays) {
    var transformedDays = _moveLastToFirst(selectedDays);
    List<int> selectedIndices = [];
    for (int i = 0; i < transformedDays.length; i++) {
      if (transformedDays[i]) {
        selectedIndices.add(i  ); 
      }
    }
    return selectedIndices;
  }

List<bool> _moveLastToFirst(List<bool> lista) {
  if (lista.isEmpty) return lista;
  
  bool ultimoElemento = lista[lista.length - 1];
  List<bool> novaLista = [ultimoElemento, ...lista.sublist(0, lista.length - 1)];
  
  return novaLista;
}


int retornaDiaDateTime(int day){

  //transformar a lista recebida da pagina para os dias exatos do dateTime
  /*
    DateTime.monday: 1
    DateTime.tuesday: 2
    DateTime.wednesday: 3
    DateTime.thursday: 4
    DateTime.friday: 5
    DateTime.saturday: 6
    DateTime.sunday: 7
  */
  
  switch (day) {
    case 1:
      return 7;
    case 2:
      return 1;
    case 3:
      return 2;
    case 4:
      return 3;
    case 5:
      return 4;
    case 6:
      return 5;
    case 0:
      return 6;
    default:
      return 0;
  }
  
}