var cat = Animal.CreateNewAnimal("cat", "Whiskey", DateTime.Now);

Console.WriteLine("meow");

int animalCount = 0;
List<Animal> animals = new();

GetMenu();

void GetMenu()
{
    Console.WriteLine("[1] Add animal");
    Console.WriteLine("[2] Get commands");
    Console.WriteLine("[3] Learn command");
    Console.WriteLine("[4] Get animals by birthdate");
    Console.WriteLine($"    Animals: {animalCount}");

    Route(Console.ReadKey().Key);
    Console.WriteLine();
    ReturnMenu();
}

void ReturnMenu()
{
    Console.WriteLine($"Press enter to show menu");

    while(true)
    {
        if(Console.ReadKey().Key == ConsoleKey.Enter)
        {
            Console.Clear();
            GetMenu();
            break;
        }
    }
}

void Route(ConsoleKey key)
{
    Console.Clear();

    switch (key)
    {
        case ConsoleKey.D1:
            AddAnimal();
            break;
        case ConsoleKey.D2:
            Console.WriteLine("Enter id:");
            GetCommands(Guid.Parse(Console.ReadLine()));
            break;
        case ConsoleKey.D3:
            Console.WriteLine("Enter id, command or empty string for return:");
            string[] input = Console.ReadLine().Replace(" ", "").Split(",");
            if (string.IsNullOrEmpty(input[0]))
            {
                ReturnMenu();
                return;
            }
            LearnCommand(Guid.Parse(input[0]), input[1]);
            break;
        case ConsoleKey.D4:
            OrderByBirthdate();
            break;

        default:
            Console.WriteLine("Unknown input");
            GetMenu();
            break;
    };
}

void OrderByBirthdate()
{
    Console.WriteLine(string.Join('\n', animals.OrderBy(animal => animal.Birthdate).ToList()));
}

void LearnCommand(Guid Id, string command)
{
    animals.Single(animal => animal.Id == Id).Commands.Add(command);
}

void GetCommands(Guid Id)
{
    Console.WriteLine();
    Console.WriteLine("Commands: ");
    Console.WriteLine(string.Join('\n', animals.Single(animal => animal.Id == Id).Commands));
}

void AddAnimal()
{
    Console.WriteLine("Enter type, name, birthday:");
    Console.WriteLine();
    string[] input = Console.ReadLine().Replace(" ", "").Split(",");

    var animal = Animal.CreateNewAnimal(input[0], input[1], DateTime.Parse(input[2]));

    animals.Add(animal);

    animalCount++;

    Console.WriteLine();

    Console.WriteLine(animal);
}