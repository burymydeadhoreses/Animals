abstract class Animal(string name, DateTime birthdate, List<string> commands)
{
    public Guid Id { get; private set; } = Guid.NewGuid();
    public string Name { get; private set; } = name;
    public DateTime Birthdate { get; private set; } = birthdate;
    public List<string> Commands { get; private set; } = commands;

    public static Animal CreateNewAnimal(string type, string name, DateTime birthdate)
    {
        return type.ToUpper() switch
        {
            "CAT" => new Cat(type, name, birthdate, new List<string>()),
            "DOG" => new Cat(type, name, birthdate, new List<string>()),
            "HAMSTER" => new Cat(type, name, birthdate, new List<string>()),

            "HORSE" => new Cat(type, name, birthdate, new List<string>()),
            "CAMEL" => new Cat(type, name, birthdate, new List<string>()),
            "DONKEY" => new Cat(type, name, birthdate, new List<string>()),

            _ => throw new ArgumentException("No such animal type")
        };
    }

    public virtual void LearnCommand(string command)
    {
        Commands.Add(command);
    }

    public override string ToString()
    {
        return $"Id: {Id},\nName: {Name},\nBirthdate: {Birthdate},\nCommands:\n{string.Join('\n', Commands)}";
    }
}
abstract class Pet(string type, string name, DateTime birthdate, List<string> commands) : Animal(name, birthdate, commands)
{
    public string Type { get; private set; } = type;

    public override string ToString()
    {
        return $"Type: {Type},\n" + base.ToString();
    }
}
abstract class Pack(string type, string name, DateTime birthdate, List<string> commands) : Animal(name, birthdate, commands)
{
    public string Type { get; private set; } = type;

    public override string ToString()
    {
        return $"Type: {Type},\n" + base.ToString();
    }
}

class Cat(string type, string name, DateTime birthdate, List<string> commands) : Pet(type, name, birthdate, commands)
{
}
class Dog(string type, string name, DateTime birthdate, List<string> commands) : Pet(type, name, birthdate, commands)
{
}
class Hamster(string type, string name, DateTime birthdate, List<string> commands) : Pet(type, name, birthdate, commands)
{
}
class Horse(string type, string name, DateTime birthdate, List<string> commands) : Pack(type, name, birthdate, commands)
{
}
class Camel(string type, string name, DateTime birthdate, List<string> commands) : Pack(type, name, birthdate, commands)
{
}
class Donkey(string type, string name, DateTime birthdate, List<string> commands) : Pack(type, name, birthdate, commands)
{
}
