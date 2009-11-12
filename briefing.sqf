

player creatediaryrecord ["Diary",["Context","Choose your objectif."]];


obj4 = player createsimpletask["Kill"];
obj4 setsimpletaskdescription["Kill the high <marker name='High_command'>officier</marker> of region.", "Kill", "Kill"];

obj3 = player createsimpletask["Clean"];
obj3 setsimpletaskdescription["Clean the <marker name='obj3'>zone3<*marker>.", "Clean", "Clean"];

obj2 = player createsimpletask["Clean"];
obj2 setsimpletaskdescription["Clean the <marker name='obj2'>zone2</marker>.", "Clean", "Clean"];

obj1 = player createSimpleTask["Clean"];
obj1 setSimpleTaskDescription["Clean the <marker name='obj1'>zone1</marker>.", "Clean", "Clean"];