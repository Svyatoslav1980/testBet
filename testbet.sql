-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Апр 15 2021 г., 01:36
-- Версия сервера: 10.3.22-MariaDB
-- Версия PHP: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `testbet`
--

-- --------------------------------------------------------

--
-- Структура таблицы `bets`
--

CREATE TABLE `bets` (
  `bet_id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `matchId` int(11) NOT NULL,
  `bet_result` enum('w1','w2','d') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `is_paid` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `bets`
--

INSERT INTO `bets` (`bet_id`, `userId`, `matchId`, `bet_result`, `amount`, `is_paid`) VALUES
(1, 2, 1, 'w1', '88.30', 1),
(5, 2, 4, 'w1', '200.00', 0),
(6, 1, 3, 'w1', '16.81', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `exchange_rates`
--

CREATE TABLE `exchange_rates` (
  `id` int(11) NOT NULL,
  `rate_name` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` float(10,2) NOT NULL DEFAULT 1.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `exchange_rates`
--

INSERT INTO `exchange_rates` (`id`, `rate_name`, `rate`) VALUES
(1, 'RUR', 91.65),
(2, 'USD', 1.19);

-- --------------------------------------------------------

--
-- Структура таблицы `matches`
--

CREATE TABLE `matches` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `team1` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `team2` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `team1_win_rate` decimal(10,2) NOT NULL,
  `team2_win_rate` decimal(10,2) NOT NULL,
  `draw` decimal(10,2) NOT NULL,
  `match_result` enum('w1','w2','d') COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `matches`
--

INSERT INTO `matches` (`id`, `date`, `team1`, `team2`, `team1_win_rate`, `team2_win_rate`, `draw`, `match_result`) VALUES
(1, '2021-04-13', 'Arsenal', 'Flora', '1.15', '3.55', '2.40', 'w1'),
(2, '2021-04-14', 'Real Madrid', 'Paide', '5.20', '2.30', '3.45', NULL),
(3, '2021-04-15', 'Zenit', 'Chelsea', '5.20', '2.10', '2.00', NULL),
(4, '2021-04-15', 'Nömme Kalju', 'Ajax', '6.00', '3.30', '2.50', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `login` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` enum('male','female','other') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birthday` date NOT NULL,
  `phone1` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone2` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adress` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rights` enum('u','a') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'u',
  `sum_eur` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `password`, `first_name`, `last_name`, `gender`, `birthday`, `phone1`, `phone2`, `adress`, `city`, `email`, `rights`, `sum_eur`) VALUES
(1, 'vasja', 'vasja', 'Vasil', 'Vasilenko', 'male', '1980-02-02', '12345678', NULL, 'Punane str., 20-4', 'Tallinn', 'vasja@email.com', 'u', '183.19'),
(2, 'petja', 'petja', 'Petro', 'Petrenko', 'male', '1983-06-03', '87654321', NULL, 'Ehitajate tee 3-45', 'Tallinn', 'petja@email.com', 'u', '1864.76');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `bets`
--
ALTER TABLE `bets`
  ADD PRIMARY KEY (`bet_id`),
  ADD KEY `userId` (`userId`),
  ADD KEY `matchId` (`matchId`);

--
-- Индексы таблицы `exchange_rates`
--
ALTER TABLE `exchange_rates`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `matches`
--
ALTER TABLE `matches`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `bets`
--
ALTER TABLE `bets`
  MODIFY `bet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `exchange_rates`
--
ALTER TABLE `exchange_rates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `matches`
--
ALTER TABLE `matches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `bets`
--
ALTER TABLE `bets`
  ADD CONSTRAINT `bets_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bets_ibfk_2` FOREIGN KEY (`matchId`) REFERENCES `matches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
