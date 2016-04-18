﻿&НаКлиенте
Перем СчетчикОжиданияРезультатов;

&НаКлиенте
Перем МаксИтерацийОжиданияРезультатов;

&НаКлиенте
Перем ИндикаторВыполнения;

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ПодключитьОбработчикОжидания("ПроверитьНеобходимостьЗавершенияПрограммы", 10, Истина);
	
КонецПроцедуры

&НаКлиенте 
Процедура ПроверитьНеобходимостьЗавершенияПрограммы()
	Перем НеобходимоОжидание, МожноЗавершатьРаботу;
	
	НеобходимоОжидание = (Найти(ПараметрЗапуска, "ЗавершитьРаботуСистемы") > 0);
	МожноЗавершатьРаботу = Ложь;
	//СтрокаОшибкиОбновления = Нрег("Не выполнены дополнительные процедуры обработки данных");
	СтрокаНеудачиОбновления = Нрег("Не удалось выполнить обновление");
	
	ФормаОбновленияНайденна = Ложь;
	РезультатОбновленияНайден = Ложь;
	
	Окна = ПолучитьОкна();
	Для каждого Окн Из Окна Цикл
		Если ТипЗнч(Окн) = Тип("ОкноКлиентскогоПриложения") Тогда
			
			Содержимое = Окн.ПолучитьСодержимое();
			Если Найти(НРег(Строка(Окн.Заголовок)), "обновление версии")>0 Тогда
				СчетчикОжиданияРезультатов = 1;
				ПроцентВыполнения = 0;
				Попытка
					Если ТипЗнч(Содержимое) = Тип("УправляемаяФорма") Тогда
						ПроцентВыполнения = Содержимое.ПрогрессВыполнения;
					КонецЕсли; 
				Исключение
				    Сообщить(ОписаниеОшибки());
				КонецПопытки; 
				
				Если ПроцентВыполнения <> ИндикаторВыполнения Тогда
					ИндикаторВыполнения = ПроцентВыполнения;
					СтрокаСообщения = ""+ТекущаяДата() + " - " + ПроцентВыполнения + "% Нашли форму обновления подождем еще";
					Сообщить(СтрокаСообщения);
				КонецЕсли; 
				
			КонецЕсли;
			
			Если СчетчикОжиданияРезультатов > 0 И Найти(НРег(Строка(Окн.Заголовок)), "что нового в конфигурации")>0 Тогда
				СчетчикОжиданияРезультатов = МаксИтерацийОжиданияРезультатов + 1;
				Сообщить(""+ТекущаяДата() + " - Удачное завершение обновления");
				МожноЗавершатьРаботу = Истина;
				Прервать;
			КонецЕсли;
			
			//Если (Найти(НРег(Строка(Окн.Заголовок)), СтрокаОшибкиОбновления)>0 
				//	ИЛИ 
				Если Найти(НРег(Строка(Окн.Заголовок)), СтрокаНеудачиОбновления)>0 Тогда 
			    СчетчикОжиданияРезультатов = МаксИтерацийОжиданияРезультатов + 1;
				МожноЗавершатьРаботу = Истина;
				
				Попытка
					Если ТипЗнч(Содержимое) = Тип("УправляемаяФорма") Тогда
						ТекстОшибки = Содержимое.Элементы.ТекстСообщенияОбОшибке.Заголовок;
						Сообщить("ERROR: "+ТекущаяДата() + " "+ТекстОшибки);
					КонецЕсли; 
					
				Исключение
				 	Сообщить("ERROR: "+ТекущаяДата() + ОписаниеОшибки());   
				КонецПопытки; 
				
				Сообщить("ERROR: "+ТекущаяДата() + "Неудачное обновление конфигурации");
				Прервать;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Если НеобходимоОжидание И МожноЗавершатьРаботу = Ложь И СчетчикОжиданияРезультатов <= МаксИтерацийОжиданияРезультатов Тогда
		СчетчикОжиданияРезультатов = СчетчикОжиданияРезультатов + 1;
		ПодключитьОбработчикОжидания("ПроверитьНеобходимостьЗавершенияПрограммы", 10, Истина);
	КонецЕсли; 
			
	
	Если СчетчикОжиданияРезультатов > МаксИтерацийОжиданияРезультатов И НеобходимоОжидание = Истина Тогда
		Сообщить(""+ТекущаяДата() + " - "+"Завершаем работу");
		
		Если Не Содержимое = Неопределено И ТипЗнч(Содержимое) = Тип("УправляемаяФорма") Тогда
			Содержимое.Закрыть();
		КонецЕсли;
		
		ПодключитьОбработчикОжидания("ЗавершитьРаботу", 5, Истина);
		
		
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ЗавершитьРаботу() Экспорт 
	ЗавершитьРаботуСистемы(Истина);
КонецПроцедуры
 
 
СчетчикОжиданияРезультатов = 0;
МаксИтерацийОжиданияРезультатов = 5;
ИндикаторВыполнения = 0;