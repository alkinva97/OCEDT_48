///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Возвращает Истина, если текущему пользователю доступна по меньшей мере одна учетная запись для отправки.
Функция ЕстьДоступныеУчетныеЗаписиДляОтправки() Экспорт
	Возврат РаботаСПочтовымиСообщениями.ДоступныеУчетныеЗаписи(Истина).Количество() > 0;
КонецФункции

// Проверяет возможность добавления пользователем новых учетных записей.
Функция ДоступноПравоДобавленияУчетныхЗаписей() Экспорт 
	Возврат ПравоДоступа("Добавление", Метаданные.Справочники.УчетныеЗаписиЭлектроннойПочты);
КонецФункции

Функция СведенияДляОтправки(ПараметрыОтправки) Экспорт
	Перем Вложения;
	
	ПараметрыОтправки.Свойство("Вложения", Вложения);
	ПараметрыОтправки.Вложения = РаботаСПочтовымиСообщениямиСлужебный.ОписанияВложений(Вложения);
	
	Результат = Новый Структура;
	Результат.Вставить("ЕстьДоступныеУчетныеЗаписиДляОтправки", ЕстьДоступныеУчетныеЗаписиДляОтправки());
	Результат.Вставить("ДоступноПравоДобавленияУчетныхЗаписей", ДоступноПравоДобавленияУчетныхЗаписей());
	Результат.Вставить("ПоказыватьДиалогВыбораФорматаСохраненияВложений", ЕстьТабличныеДокументыВоВложениях(ПараметрыОтправки.Вложения));
	
	Возврат Результат;
КонецФункции

Функция ЕстьТабличныеДокументыВоВложениях(Вложения)
	Если Вложения = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Для Каждого ОписаниеВложения Из Вложения Цикл
		Если ТипЗнч(ПолучитьИзВременногоХранилища(ОписаниеВложения.АдресВоВременномХранилище)) = Тип("ТабличныйДокумент") Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;
КонецФункции

Процедура ПодготовитьВложения(Вложения, НастройкиСохранения) Экспорт
	РаботаСПочтовымиСообщениямиСлужебный.ПодготовитьВложения(Вложения, НастройкиСохранения);
КонецПроцедуры

#КонецОбласти
